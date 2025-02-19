require 'puma'
require 'sinatra'
require 'json'

# 環境変数 PORT が指定されていれば使用、なければ 4567 をデフォルトとする
port = ENV.fetch('PORT', 4567).to_i

# ヘッダー情報表示の有無
LOG_HEADERS = ENV['LOG_HEADERS']&.downcase == 'true'

# Puma を明示的に使用
set :server, :puma
set :bind, '0.0.0.0'
set :port, port  # 環境変数でポートを指定

puts "🚀 Sinatra Server is running on port #{port}"

# CORS を許可
before do
  response.headers['Access-Control-Allow-Origin'] = '*'
  response.headers['Access-Control-Allow-Methods'] = 'OPTIONS, GET, POST, PUT, PATCH, DELETE'
  response.headers['Access-Control-Allow-Headers'] = 'Content-Type'
end

# CORS プリフライトリクエストをすべてのパスで受け付ける
options '/*' do
  # リクエストヘッダーを取得（LOG_HEADERS が有効なら取得）
  headers = if LOG_HEADERS
    request.env.select { |k, _| k.start_with?('HTTP_') }
               .transform_keys { |k| k.sub(/^HTTP_/, '').split('_').map(&:capitalize).join('-') }
  else
    {}
  end

  puts "📩 [OPTIONS] #{request.path_info} 受信（プリフライトリクエスト）"
  puts "📩 ヘッダー情報: #{headers}" if LOG_HEADERS

  status 200
end

# すべてのHTTPメソッドを受け付ける
['GET', 'POST', 'PUT', 'PATCH', 'DELETE'].each do |method|
  send(method.downcase, '/*') do
    request.body.rewind
    data = request.body.read
    json_data = data.empty? ? {} : (JSON.parse(data) rescue { raw: data })

    # ヘッダー情報を取得（HTTP_ で始まるものを抽出）
    # 環境変数が有効ならヘッダー情報を取得
    headers = if LOG_HEADERS
      request.env.select { |k, _| k.start_with?('HTTP_') }
                 .transform_keys { |k| k.sub(/^HTTP_/, '').split('_').map(&:capitalize).join('-') }
    else
      {}
    end

    puts "📩 [#{request.request_method}] #{request.path_info} 受信データ: #{json_data}"
    puts "📩 ヘッダー情報: #{headers}" if LOG_HEADERS

    content_type :json
    { 
      status: 'success', 
      method: request.request_method, 
      path: request.path_info, 
      headers: headers,
      received: json_data 
    }.to_json
  end
end