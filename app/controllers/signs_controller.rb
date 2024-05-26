class SignsController < ApplicationController

  def index
    require 'faraday' # Faradayを使用する場合
    require 'json'

    # Bearer 
    token = ENV['BEARER_TOKEN']

    current_time = Time.now

    # Faradayのインスタンスを作成
    conn = Faraday.new(url: 'https://app.livlog.xyz/hoshimiru/constellation')

    # リクエストヘッダーに認証情報を含める
    conn.headers['Authorization'] = "Bearer #{token}"
    conn.headers['Accept'] = 'application/json'

    # APIエンドポイントにリクエストを送信
    response = conn.get do |req|
      req.url '', { lat: '35.6895', lng: '139.6917', date: current_time.strftime('%Y-%m-%d'), hour: current_time.strftime('%H'), min: current_time.strftime('%M'), disp:"on" }
    end

    # レスポンスを解析
    @data = JSON.parse(response.body)
  end

  def show
  end

end
