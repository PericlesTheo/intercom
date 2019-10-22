# frozen_string_literal: true

require_relative "../app/location"

RSpec.describe Location do
  describe "initialize" do
    it "raises an error if latitude is not valid" do
      expect { Location.new("1a", "111.11") }.to raise_error(described_class::Invalid, "Invalid coordinate: 1a")
    end

    it "raises an error if longitude is not valid" do
      expect { Location.new("-11323.03", "121a") }.to raise_error(described_class::Invalid, "Invalid coordinate: 121a")
    end
  end

  describe "#distance_from" do
    it "calculates correctly the distance between the Empire State Building and London Eye" do
      london_eye = described_class.new(51.50328025, -0.119687322282424)
      empire_state_building = Location.new(40.7484284, -73.9856546198733)

      distance = london_eye.distance_from(empire_state_building)

      expect(distance.round).to eq(5567)
    end

    it "returns 0 if the two coordinates are the same" do
      london_eye = described_class.new(51.50328025, -0.119687322282424)

      distance = london_eye.distance_from(london_eye)

      expect(distance.round).to eq(0)
    end

    it "returns 0 if the two coordinates are less than 1km away" do
      london_eye = described_class.new(51.50328025, -0.119687322282424)
      big_ben = described_class.new(51.5007, -0.1246)

      distance = london_eye.distance_from(big_ben)

      expect(distance.round).to eq(0)
    end
  end
end
