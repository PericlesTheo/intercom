# frozen_string_literal: true

require "json"

require_relative "./location"

class Customer
  def self.load_from_file(file)
    file.each_line.reject(&:empty?).map do |line|
      opts = JSON.parse(line).transform_keys(&:to_sym)

      Customer.new(opts)
    end
  end

  attr_reader :user_id, :name, :location

  def initialize(latitude:, longitude:, user_id:, name:)
    @location = Location.new(latitude, longitude)
    @user_id = user_id
    @name = name
  end

  def <=>(other)
    if user_id < other.user_id
      -1
    elsif user_id > other.user_id
      1
    else
      0
    end
  end
end
