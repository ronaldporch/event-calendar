require 'date'
class EventController < ApplicationController
  def index
    params = date_params[:day] ? date_params : {day: Date.today.yday, year: Date.today.year}
    @date = Date.ordinal(params[:year].to_i, params[:day].to_i)
    @datePrev = "/?day=#{(@date - 1.day).yday}&year=#{(@date - 1.day).year}"
    @dateNext = "/?day=#{(@date + 1.day).yday}&year=#{(@date + 1.day).year}"
    events = Event.of_date(params)
    @tracks = Track.all.order(order: :asc)
    @time = ("07".."19").to_a.map{|h|
      ["00","15","30","45"].map{|m|
        "#{h}:#{m}"
      }
    }.flatten
    @trackEvents = []
    @tracks.each do |t|
      @trackEvents[t.id] = []
      events.each do |e|
        if e.track_ids.include? t.id
          @trackEvents[t.id].push(e)
        end
      end
    end
  end

  private
  def date_params
    params.permit(:day, :year)
  end
end
