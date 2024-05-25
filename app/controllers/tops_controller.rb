class TopsController < ApplicationController

  def top
    require 'faraday'
    require 'json'

    token = ENV['BEARER_TOKEN']

    conn = Faraday.new(url: 'https://app.livlog.xyz/hoshimiru/constellation') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
      faraday.headers['Authorization'] = "Bearer #{token}"
    end

    response = conn.get do |req|
      req.url '', { lat: 35.6581, lng: 139.7414, date: '2024-05-25', hour: '20', min: '00' }
    end

    @data = JSON.parse(response.body)

 
  end

end
