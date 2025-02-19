# Request Logger 📝

**Request Logger** は、すべてのHTTPリクエストを受信し、ログに出力するシンプルなデバッグツールです。  
ローカル環境でのフロントエンドやAPIの開発時に、リクエストデータの確認用途での利用が可能です。  
ngrokやCloudflare Tunnelなどのプロキシサービスと組み合わせることで、外部からのリクエストデータについても確認が出来ます。  

## 特徴

- 指定ポートにてHTTPリクエストを受信、ログに出力
  - localhost:<指定ポート>/*
- シンプルなSinatraベースの実装
- Docker、Docker Composeに対応
- 環境変数で受付ポートやヘッダー情報出力の有無をカスタマイズ

## 動作例

### ヘッダ表示有り(LOG_HEADERS=true)
<details>
  <summary>展開</summary>

```
tky@TKYPC:~/docker-project/request-logger$ docker compose up
[+] Running 1/1
 ✔ Container request-logger-request-logger-1  Created                                                  0.0s
Attaching to request-logger-1
request-logger-1  | == Sinatra (v4.1.1) has taken the stage on 1234 for development with backup from Puma
request-logger-1  | 🚀 Sinatra Server is running on port 1234
request-logger-1  | Puma starting in single mode...
request-logger-1  | * Puma version: 6.6.0 ("Return to Forever")
request-logger-1  | * Ruby version: ruby 3.4.2 (2025-02-15 revision d2930f8e7a) +PRISM [x86_64-linux]
request-logger-1  | *  Min threads: 0
request-logger-1  | *  Max threads: 5
request-logger-1  | *  Environment: development
request-logger-1  | *          PID: 1
request-logger-1  | * Listening on http://0.0.0.0:1234
request-logger-1  | Use Ctrl-C to stop
request-logger-1  | 📩 [GET] / 受信データ: {}
request-logger-1  | 📩 ヘッダー情報: {"Host" => "localhost:1234", "Connection" => "keep-alive", "Cache-Control" => "max-age=0", "Sec-Ch-Ua" => "\"Not A(Brand\";v=\"8\", \"Chromium\";v=\"132\", \"Google Chrome\";v=\"132\"", "Sec-Ch-Ua-Mobile" => "?0", "Sec-Ch-Ua-Platform" => "\"Windows\"", "Upgrade-Insecure-Requests" => "1", "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36", "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7", "Sec-Fetch-Site" => "none", "Sec-Fetch-Mode" => "navigate", "Sec-Fetch-User" => "?1", "Sec-Fetch-Dest" => "document", "Accept-Encoding" => "gzip, deflate, br, zstd", "Accept-Language" => "ja,en-US;q=0.9,en;q=0.8", "Version" => "HTTP/1.1"}
request-logger-1  | 172.18.0.1 - - [19/Feb/2025:15:55:13 +0000] "GET / HTTP/1.1" 200 817 0.0024
request-logger-1  | 📩 [GET] /favicon.ico 受信データ: {}
request-logger-1  | 📩 ヘッダー情報: {"Host" => "localhost:1234", "Connection" => "keep-alive", "Sec-Ch-Ua-Platform" => "\"Windows\"", "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36", "Sec-Ch-Ua" => "\"Not A(Brand\";v=\"8\", \"Chromium\";v=\"132\", \"Google Chrome\";v=\"132\"", "Sec-Ch-Ua-Mobile" => "?0", "Accept" => "image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8", "Sec-Fetch-Site" => "same-origin", "Sec-Fetch-Mode" => "no-cors", "Sec-Fetch-Dest" => "image", "Referer" => "http://localhost:1234/", "Accept-Encoding" => "gzip, deflate, br, zstd", "Accept-Language" => "ja,en-US;q=0.9,en;q=0.8", "Version" => "HTTP/1.1"}
request-logger-1  | 172.18.0.1 - - [19/Feb/2025:15:55:13 +0000] "GET /favicon.ico HTTP/1.1" 200 713 0.0006
request-logger-1  | 📩 [OPTIONS] /api/memos 受信（プリフライトリクエスト）
request-logger-1  | 📩 ヘッダー情報: {"Host" => "localhost:1234", "Connection" => "keep-alive", "Accept" => "*/*", "Access-Control-Request-Method" => "POST", "Access-Control-Request-Headers" => "content-type", "Access-Control-Request-Private-Network" => "true", "Origin" => "https://github.com", "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36", "Sec-Fetch-Mode" => "cors", "Sec-Fetch-Site" => "cross-site", "Sec-Fetch-Dest" => "empty", "Accept-Encoding" => "gzip, deflate, br, zstd", "Accept-Language" => "ja,en-US;q=0.9,en;q=0.8", "Version" => "HTTP/1.1"}
request-logger-1  | 172.18.0.1 - - [19/Feb/2025:15:55:35 +0000] "OPTIONS /api/memos HTTP/1.1" 200 - 0.0007
request-logger-1  | 📩 [POST] /api/memos 受信データ: {"text" => "Hello World!!"}
request-logger-1  | 📩 ヘッダー情報: {"Host" => "localhost:1234", "Connection" => "keep-alive", "Sec-Ch-Ua-Platform" => "\"Windows\"", "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36", "Sec-Ch-Ua" => "\"Not A(Brand\";v=\"8\", \"Chromium\";v=\"132\", \"Google Chrome\";v=\"132\"", "Sec-Ch-Ua-Mobile" => "?0", "Accept" => "*/*", "Origin" => "https://github.com", "Sec-Fetch-Site" => "cross-site", "Sec-Fetch-Mode" => "cors", "Sec-Fetch-Dest" => "empty", "Accept-Encoding" => "gzip, deflate, br, zstd", "Accept-Language" => "ja,en-US;q=0.9,en;q=0.8", "Version" => "HTTP/1.1"}
request-logger-1  | 172.18.0.1 - - [19/Feb/2025:15:55:35 +0000] "POST /api/memos HTTP/1.1" 200 664 0.0007
```
</details>

### ヘッダ表示無し(LOG_HEADERS=false)
<details>
  <summary>展開</summary>

```
tky@TKYPC:~/docker-project/request-logger$ docker compose up
[+] Running 1/1
 ✔ Container request-logger-request-logger-1  Created                                                  0.0s
Attaching to request-logger-1
request-logger-1  | == Sinatra (v4.1.1) has taken the stage on 1234 for development with backup from Puma
request-logger-1  | 🚀 Sinatra Server is running on port 1234
request-logger-1  | Puma starting in single mode...
request-logger-1  | * Puma version: 6.6.0 ("Return to Forever")
request-logger-1  | * Ruby version: ruby 3.4.2 (2025-02-15 revision d2930f8e7a) +PRISM [x86_64-linux]
request-logger-1  | *  Min threads: 0
request-logger-1  | *  Max threads: 5
request-logger-1  | *  Environment: development
request-logger-1  | *          PID: 1
request-logger-1  | * Listening on http://0.0.0.0:1234
request-logger-1  | Use Ctrl-C to stop
request-logger-1  | 📩 [GET] / 受信データ: {}
request-logger-1  | 172.18.0.1 - - [19/Feb/2025:15:05:24 +0000] "GET / HTTP/1.1" 200 60 0.0010
request-logger-1  | 📩 [GET] /favicon.ico 受信データ: {}
request-logger-1  | 172.18.0.1 - - [19/Feb/2025:15:05:24 +0000] "GET /favicon.ico HTTP/1.1" 200 71 0.0007
request-logger-1  | 172.18.0.1 - - [19/Feb/2025:15:05:43 +0000] "OPTIONS /api/memos HTTP/1.1" 200 - 0.0004
request-logger-1  | 📩 [POST] /api/memos 受信データ: {"text" => "Hello, World!"}
request-logger-1  | 172.18.0.1 - - [19/Feb/2025:15:05:43 +0000] "POST /api/memos HTTP/1.1" 200 92 0.0005
```
</details>

## 起動方法

### 起動

- `docker-compose up`

### 初回起動

- `git clone https://github.com/TKY413/request-logger.git`
- `cd request-logger`
- `cp .env.sample .env`
- リクエストの受信ポートを初期値(4567)から変更したい場合は.env内のPORT環境変数を変更してください
- リクエストのヘッダー情報の表示有無を変更したい場合には、.env内のLOG_HEADERS環境変数(true/false)を変更してください
- `docker-compose up`

# ライセンス

MIT License
