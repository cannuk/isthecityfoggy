class ForecastController < ApplicationController

  def index
    render :json => Hour.all.to_json, :callback => params['callback']
  end

  def current
    hour = Time.new().hour
    render :json => Hour.where(:hour => hour).order(:hour).to_json, :callback => params['callback']
  end

end
