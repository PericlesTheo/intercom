# frozen_string_literal: true
require "tempfile"

require_relative "../app/customer"

RSpec.describe Customer do
  describe ".load_from_file" do
    it "loads a list of customers from a file" do
      file = File.open("./spec/fixtures/customers.txt")

      customers = described_class.load_from_file(file)

      expect(customers.size).to eq(2)
      expect(customers.map(&:user_id)).to eq([12, 1])
    ensure
      file.close
    end

    it "works if there are empty lines" do
      file = Tempfile.new("empty-lines.txt")
      data = { latitude: 51.8856167, user_id: 2, name: "Ian McArdle", longitude: "-10.4240951" }
      file << "#{data.to_json}\n#{data.to_json}"
      file.rewind

      customers = described_class.load_from_file(file)

      expect(customers.size).to eq(2)
    ensure
      file.close
      file.unlink
    end
  end

  describe "<=>" do
    it "places the customer to the end if their ID is larger than the other customer's" do
      christina = described_class.new(latitude: "52.986375", user_id: 12, name: "Christina", longitude: "-6.043701")
      maria = described_class.new(latitude: "52.986375", user_id: 11, name: "Maria", longitude: "-6.043701")

      expect([maria, christina].sort).to eq([maria, christina])
    end

    it "sorts the customer to beginning if their ID is smaller than the other customer's" do
      maria = described_class.new(latitude: "52.986375", user_id: 11, name: "Maria", longitude: "-6.043701")
      christina = described_class.new(latitude: "52.986375", user_id: 9, name: "Christina", longitude: "-6.043701")

      expect([maria, christina].sort).to eq([christina, maria])
    end

    it "sorts them at the same order if they have the same ID" do
      george = described_class.new(latitude: "52.986375", user_id: 100, name: "George", longitude: "-6.043701")
      maria = described_class.new(latitude: "52.986375", user_id: 10, name: "Maria", longitude: "-6.043701")
      akash = described_class.new(latitude: "52.986375", user_id: 2, name: "Akash", longitude: "-6.043701")
      christina = described_class.new(latitude: "52.986375", user_id: 10, name: "Christina", longitude: "-6.043701")

      expect([george, maria, akash, christina].sort).to eq([akash, maria, christina, george])
    end

    it "works with alphanumeric IDs" do
      maria = described_class.new(latitude: "52.986375", user_id: "a11", name: "Maria", longitude: "-6.043701")
      christina = described_class.new(latitude: "52.986375", user_id: "b9", name: "Christina", longitude: "-6.043701")

      expect([maria, christina].sort).to eq([maria, christina])
    end
  end
end
