class PlanetsController < ApplicationController
  require 'faraday'
  require 'json'

  def index
    # 現在の日時を取得
    current_time = Time.now

    lat = session[:latitude] || '35.6581'  # デフォルト値を設定
    lng = session[:longitude] || '139.7414'  # デフォルト値を設定

    # Bearer 
    token = ENV['BEARER_TOKEN']

    # 惑星の情報を取得
    planets_conn = Faraday.new(url: 'https://app.livlog.xyz/hoshimiru/planet') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
      faraday.headers['Authorization'] = "Bearer #{token}"
      faraday.headers['Accept'] = 'application/json'
    end

    planets_response = planets_conn.get do |req|
      req.url '', { lat: lat, lng: lng, date: current_time.strftime('%Y-%m-%d'), hour: current_time.strftime('%H'), min: current_time.strftime('%M'), disp:"on" }
    end

    @planets_data = JSON.parse(planets_response.body)    
  end

  def show
    # 現在の日時を取得
    current_time = Time.now

    lat = session[:latitude] || '35.6581'  # デフォルト値を設定
    lng = session[:longitude] || '139.7414'  # デフォルト値を設定

    # Bearer 
    token = ENV['BEARER_TOKEN']

    # 惑星の情報を取得
    planets_conn = Faraday.new(url: 'https://app.livlog.xyz/hoshimiru/planet') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
      faraday.headers['Authorization'] = "Bearer #{token}"
      faraday.headers['Accept'] = 'application/json'
    end

    planets_response = planets_conn.get do |req|
      req.url '', { lat: lat, lng: lng, date: current_time.strftime('%Y-%m-%d'), hour: current_time.strftime('%H'), min: current_time.strftime('%M'), id: params[:id], disp:"on" }
    end

    @planets_data = JSON.parse(planets_response.body)    
  end
end
