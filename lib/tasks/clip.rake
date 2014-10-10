
namespace :clip do

  desc "clip each hour"
  task :clip_hours => :environment do
    ff = FogForecast.new
    ff.update_forecast
  end
end
