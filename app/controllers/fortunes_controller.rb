class FortunesController < ApplicationController
  require 'faraday'
  require 'json'

  def index
    data = Time.now.strftime("%Y/%m/%d")

    conn = Faraday.new(url: "http://api.jugemkey.jp/api/horoscope/free/#{data}")

    response = conn.get

    @data = JSON.parse(response.body)

    puts @data
  end

end