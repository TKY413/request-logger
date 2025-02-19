# 1. Ruby 3.4 の公式イメージをベースにする
FROM ruby:3.4

# 2. 作業ディレクトリを設定
WORKDIR /app

# 3. 依存関係をインストールする前に Gemfile をコピー
COPY Gemfile Gemfile.lock ./

# 4. Bundler のバージョンを指定してインストール（最新の Bundler を使用）
RUN gem install bundler && bundle install --jobs=4 --retry=3

# 4. ソースコードをコンテナにコピー
COPY . .

# 6. Sinatra を Puma で起動
CMD ["bundle", "exec", "ruby", "server.rb", "-o", "0.0.0.0"]