# frozen_string_literal: true

class Location
  RADIUS_OF_EARTH = 6371

  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude.to_f
    @longitude = longitude.to_f
  end

  # This is the formula for calculating the distance between two points on the surface of a sphere
  # The return value is in kilometers
  # https://en.wikipedia.org/wiki/Great-circle_distance
  def distance_from(other_location)
    calculation = sin_latitudes(other_location) + cos_latitudes(other_location) * cos_longitude(other_location)

    RADIUS_OF_EARTH * Math.atan2(Math.sqrt(calculation), Math.sqrt(1 - calculation)) * 2
  end

  protected

  def latitude_radians
    degrees_to_radians(latitude)
  end

  def longitude_radians
    degrees_to_radians(longitude)
  end

  private

  def degrees_to_radians(degrees)
    degrees * (Math::PI / 180)
  end

  def sin_latitudes(other)
    delta = degrees_to_radians(other.latitude - latitude)

    Math.sin(delta / 2)**2
  end

  def cos_latitudes(other)
    Math.cos(latitude_radians) * Math.cos(other.latitude_radians)
  end

  def cos_longitude(other)
    delta = degrees_to_radians(other.longitude - longitude)

    Math.sin(delta / 2)**2
  end
end
