require 'csv'
namespace :import do
	desc "import data from csv"
	task events: :environment do
		CSV.foreach('events.csv') do |row|
			next if row[0] == "start"
			if row[3][6].to_i != 0
				p row[3]

				track = Track.new(name: row[3], order: row[3][6])
				if track.save()
				end
			end
		end
		CSV.foreach('events.csv') do |row|
			next if row[0] == "start"
			track = Track.find_by_name(row[3])
			track = track ? [track.id] : [1,2,3,4,5]
			start = DateTime.strptime(row[0].gsub("/", "-"), '%m-%d-%Y %k:%M')
			finish = DateTime.strptime(row[1].gsub("/", "-"), '%m-%d-%Y %k:%M')
			event = {name: row[2], start: start, finish: finish, track_ids: track}
			p event
			event = Event.create(event)
		end
	end
end