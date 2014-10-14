require 'RMagick'
class FogForecast

  include Colorscore
  def initialize
    @cols = 40
    @rows = 80
    @x = 200
    @y = 178
    @white = Color::RGB.new(255, 255, 255)
  end

  def update_forecast
    scores = get_scores_by_hour

    scores.each_with_index do |score, i|
      hour = Hour.where(:hour => i).first
      hour.foggy = is_foggy score
      hour.update_attribute(:updated_at,Time.now)
      hour.save

    end

  end

  def get_scores_by_hour
     images = Magick::ImageList.new("http://dev.wunderground.com/autobrand/fogmap/topclose/fogmap.gif")
    # images = Magick::ImageList.new("./public/fogmap.gif")
    palette = Palette.from_hex(['ffffff'])
    background = Magick::Image.new(@cols, @rows)
    background.background_color = "red"
    background.write("./tmp/background.gif")
    hours = Array.new
    # frame 1 of the gif is the map, frame 2 is 2300 hrs of the previous day
    (2..25).to_a.each do |i|
      images[i].write("./tmp/fog_frame_#{i}.gif")
      # crop to the city
      cropped = images[i].crop(@x, @y, @cols, @rows, true)
      cropped.write("./tmp/frame_#{i}.gif")
      # place the crop on a white background so we can measure (the crop is transparent)
      cropped_list = Magick::ImageList.new("./tmp/background.gif", "./tmp/frame_#{i}.gif")
      cropped_list.background_color = "red"
      cropped = cropped_list.flatten_images
      cropped.write("./tmp/frame_#{i}.gif")
      histogram = Histogram.new("./tmp/frame_#{i}.gif")
      hours[(i-2)] = histogram.scores.first
    end
    hours
  end

  def is_foggy(score)
    threshold = score[0]
    color = score[1]
    # if the inital color is not even white, then its really foggy
    foggy_text = if color == @white and threshold > 0.74
      "no"
    # More than 75% white, not foggy
    elsif color == @white and threshold >= 0.69
      "probably"
    else
      "yes"
    end
    foggy_text
  end

end