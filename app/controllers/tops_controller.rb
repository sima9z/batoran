class TopsController < ApplicationController

  def top
    require 'faraday'
    require 'json'

    token = ENV['BEARER_TOKEN']
    # 現在の日時を取得
    current_time = Time.now

    # 星座の情報を取得
    conn = Faraday.new(url: 'https://app.livlog.xyz/hoshimiru/constellation') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
      faraday.headers['Authorization'] = "Bearer #{token}"
      faraday.headers['Accept'] = 'application/json'
    end

    response = conn.get do |req|
      req.url '', { lat: 35.6581, lng: 139.7414, date: current_time.strftime('%Y-%m-%d'), hour: current_time.strftime('%H'), min: current_time.strftime('%M') }
    end

    @data = JSON.parse(response.body)
  end
end
