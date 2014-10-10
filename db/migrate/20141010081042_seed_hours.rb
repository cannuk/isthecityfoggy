class SeedHours < ActiveRecord::Migration
  def change
    (0..23).each do |hour|
      hour_record = Hour.new
      hour_record.hour = hour
      hour_record.save
    end
  end
end
