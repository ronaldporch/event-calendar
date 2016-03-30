class Track < ActiveRecord::Base
	validates :name, uniqueness: true
end
