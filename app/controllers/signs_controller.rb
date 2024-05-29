class SignsController < ApplicationController
  require 'faraday' # Faradayを使用する場合
  require 'json'

  def index
    # Bearer 
    token = ENV['BEARER_TOKEN']

    current_time = Time.now

    lat = session[:latitude] || '35.6581'  # デフォルト値を設定
    lng = session[:longitude] || '139.7414'  # デフォルト値を設定

    # Faradayのインスタンスを作成
    conn = Faraday.new(url: 'https://app.livlog.xyz/hoshimiru/constellation')

    # リクエストヘッダーに認証情報を含める
    conn.headers['Authorization'] = "Bearer #{token}"
    conn.headers['Accept'] = 'application/json'

    # APIエンドポイントにリクエストを送信
    response = conn.get do |req|
      req.url '', { lat: lat, lng: lng, date: current_time.strftime('%Y-%m-%d'), hour: current_time.strftime('%H'), min: current_time.strftime('%M'), disp:"on" }
    end

    # レスポンスを解析
    data = JSON.parse(response.body)

      # 検索クエリに基づいてフィルタリング
    if params[:search].present?
      @data = data['results'].select { |result| result['jpName'].include?(params[:search]) }
    else
      @data = data['results']
    end
  end

  def show
    # Bearer 
    token = ENV['BEARER_TOKEN']

    current_time = Time.now

    lat = session[:latitude] || '35.6581'  # デフォルト値を設定
    lng = session[:longitude] || '139.7414'  # デフォルト値を設定

    # Faradayのインスタンスを作成
    conn = Faraday.new(url: 'https://app.livlog.xyz/hoshimiru/constellation')

    # リクエストヘッダーに認証情報を含める
    conn.headers['Authorization'] = "Bearer #{token}"
    conn.headers['Accept'] = 'application/json'

    # APIエンドポイントにリクエストを送信
    response = conn.get do |req|
      req.url '', { lat: lat, lng: lng, date: current_time.strftime('%Y-%m-%d'), hour: current_time.strftime('%H'), min: current_time.strftime('%M'), id: params[:id], disp:"on" }
    end

    # レスポンスを解析
    @data = JSON.parse(response.body)
  end

end
