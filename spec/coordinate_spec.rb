# frozen_string_literal: true

require_relative "../coordinate"

RSpec.describe Coordinate do
  describe "#distance_from" do
    it "calculates correctly the distance between the Empire State Building and London Eye" do
      london_eye = Coordinate.new(51.50328025, -0.119687322282424)
      empire_state_building = Coordinate.new(40.7484284, -73.9856546198733)

      distance = london_eye.distance_from(empire_state_building)

      expect(distance.round).to eq(5567)
    end

    it "returns 0 if the two coordinates are the same" do
      london_eye = Coordinate.new(51.50328025, -0.119687322282424)

      distance = london_eye.distance_from(london_eye)

      expect(distance.round).to eq(0)
    end

    it "returns 0 if the two coordinates are less than 1km away" do
      london_eye = Coordinate.new(51.50328025, -0.119687322282424)
      big_ben = Coordinate.new(51.5007, -0.1246)

      distance = london_eye.distance_from(big_ben)

      expect(distance.round).to eq(0)
    end
  end
end
