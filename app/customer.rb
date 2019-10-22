# frozen_string_literal: true

require "json"

require_relative "./location"

class Customer
  class ParsingError < StandardError; end

  def self.load_from_file(file)
    file.each_line.map.with_index do |line, index|
      begin
        opts = JSON.parse(line).transform_keys(&:to_sym)
      rescue JSON::ParserError
        raise Customer::ParsingError, "Couldn't parse customer on line #{index + 1}"
      end

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
