
namespace :forecast do

  desc "clip each hour"
  task :run => :environment do
    ff = FogForecast.new
    ff.update_forecast
  end
end
