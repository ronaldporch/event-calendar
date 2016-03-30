require "rails_helper"

RSpec.describe Event, :type => :model do
  it "returns events from date and time" do
  	params = {day: 342, year: 2015} #Events in system call on this day
    events = Event.of_date(params)
    expect(events.length).to be > 0
  end

  it "returns nothing if not events are available" do
  	params = {day: 342, year: 2016}
    events = Event.of_date(params)
    expect(events.length).to be == 0
  end

  it "outputs cell height for increments" do
  	events = Event.find_by_name("T3P4OR3 Segmentation and Registration")
  	expect(events.finish.to_s).to be == "2015-12-08 09:50:00 UTC"
  	expect(events.cell_height "09:00").to eq(100)
  end

   it "outputs cell height for increments shorter less than 15 minutes" do
  	events = Event.find_by_name("T3P4OR3 Segmentation and Registration")
  	expect(events.finish.to_s).to be == "2015-12-08 09:50:00 UTC"
  	expect(events.cell_height "09:45").to eq(33)
  end
end