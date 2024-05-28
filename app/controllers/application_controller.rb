class ApplicationController < ActionController::Base
  def update_location
    session[:latitude] = params[:latitude]
    session[:longitude] = params[:longitude]
    head :ok
  end
end
