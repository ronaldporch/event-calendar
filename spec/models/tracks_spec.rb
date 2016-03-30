require "rails_helper"

RSpec.describe Track, :type => :model do
  it "responds with ordered tracks" do
    tracks = Track.all.order(order: :asc)
    tracks.each_with_index do |track, index|
      expect(track.order).to be == index + 1
    end
  end
end