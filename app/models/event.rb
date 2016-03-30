require 'csv'
class Event < ActiveRecord::Base
	def self.of_date params
		Event.where("EXTRACT(DOY FROM start) = ? and EXTRACT(YEAR FROM start) = ?", params[:day], params[:year])
	end
	def is_in_time_increment? time
		Time.parse(time).between?(Time.parse(self.start.to_s[11..15]), Time.parse(self.finish.to_s[11..15]) - 1.minutes)
	end
	def cell_height time
		height = (Time.parse(self.finish.to_s[11..15]).to_i - Time.parse(time).to_i) / 60 * 15
		(height < 225 && height != 0) ? ((height.to_f / 225) * 100).to_i : 100
	end
end
