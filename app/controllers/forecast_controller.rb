class ForecastController < ApplicationController

  def index
    render :json => Hour.order(:hour).all.to_json, :callback => params['callback']
  end

  def current
    hour = Time.new().hour
    render :json => Hour.where(:hour => hour).order(:hour).first.to_json(), :callback => params['callback']
  end

  def time
    render :json => {:hour  => Time.now.hour, :min => Time.now.min }, :callback => params['callback']
  end

end
