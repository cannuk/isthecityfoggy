class MainController < ApplicationController

  def index
    p :params
    foggy = nil
    foggy = 'yes' if params.has_key?('yes')
    foggy = 'no' if params.has_key?('no')
    foggy = 'probably' if params.has_key?('probably')
    hour = Time.new().hour
    @current = Hour.where(:hour => hour).first
    @current.foggy = foggy unless foggy.nil?
  end

end