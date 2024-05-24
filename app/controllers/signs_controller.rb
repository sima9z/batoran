class SignsController < ApplicationController

  def index
    require 'faraday' # Faradayを使用する場合

    # Bearer 
    token = ENV['BEARER_TOKEN']

    # Faradayのインスタンスを作成
    conn = Faraday.new(url: 'https://app.livlog.xyz/hoshimiru/constellation')

    # リクエストヘッダーに認証情報を含める
    conn.headers['Authorization'] = "Bearer #{token}"
    conn.headers['Accept'] = 'application/json'

    # APIエンドポイントにリクエストを送信
    response = conn.get do |req|
      req.url '', { lat: '35.6895', lng: '139.6917', date: '2020-01-15', hour: '20', min: '00', id: '2', disp: 'on' }
    end

    # レスポンスを解析
    @data = JSON.parse(response.body)
  end

  def your_controller_method
    lat = params[:lat]
    lng = params[:lng]
    # 位置情報を使用した処理をここで行う
  end

end
