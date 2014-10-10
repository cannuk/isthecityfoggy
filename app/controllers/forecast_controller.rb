class ForecastController < ApplicationController

  def index
    render :json => Hour.all.to_json
  end

  def current
    hour = Time.new().hour
    render :json => Hour.where(:hour => hour).to_json
  end

end
