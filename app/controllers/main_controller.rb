class MainController < ApplicationController

  def index
    hour = Time.new().hour
    @current = Hour.where(:hour => hour).first
  end

end