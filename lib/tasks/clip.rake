require 'RMagick'
require 'Colorscore'
namespace :clip do
  include Colorscore
  cols = 40
  rows = 80
  x = 200
  y = 178

  desc "clip each hour"
  task :clip_hours do
    images = Magick::ImageList.new("http://dev.wunderground.com/autobrand/fogmap/topclose/fogmap.gif")
    # images = Magick::ImageList.new("./public/testimages/fogmap.gif")
    palette = Palette.from_hex(['ffffff'])
    background = Magick::Image.new(cols, rows)
    background.background_color = "red"
    background.write("./tmp/background.gif")
    hours = Array.new
    (2..25).to_a.each do |i|
      images[i].write("./tmp/fog_frame_#{i}.gif")
      cropped = images[i].crop(x, y, cols, rows, true)
      cropped.write("./tmp/frame_#{i}.gif")
      cropped_list = Magick::ImageList.new("./tmp/background.gif", "./tmp/frame_#{i}.gif")
      cropped_list.background_color = "red"
      cropped = cropped_list.flatten_images
      cropped.write("./tmp/frame_#{i}.gif")
      histogram = Histogram.new("./tmp/frame_#{i}.gif")
      hours[i] = palette.scores(histogram.scores, 1)
      p "Hour #{i}"
      p histogram.scores.first
    end

  end
end
