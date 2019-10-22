# frozen_string_literal: true

require_relative "../app"

RSpec.describe App do
  describe ".run" do
    it "includes only customers within 100km from Intercom's office order by user_id" do
      File.open("./spec/fixtures/customers.txt") do |f|
        customers = described_class.run(f)

        expect(customers.map(&:user_id)).to eq([12])
      end
    end

    it "includes only customers within max distance from Intercom's office order by user_id" do
      File.open("./spec/fixtures/customers.txt") do |f|
        customers = described_class.run(f, max_distance: Float::INFINITY)

        expect(customers.map(&:user_id)).to eq([1, 12])
      end
    end

    it "includes no customers if they are not max_distance from Intercom's office" do
      File.open("./spec/fixtures/customers.txt") do |f|
        customers = described_class.run(f, max_distance: 2)

        expect(customers.map(&:user_id)).to eq([])
      end
    end

    it "exits the system if the file parsing fails" do
      File.open("./spec/fixtures/customers_malformed_file.txt") do |f|
        described_class.run(f, max_distance: 2)

        expect($stdout).to have_received(:puts).with("There seems to be an issue with the file specified")
      end
    end
  end
end
