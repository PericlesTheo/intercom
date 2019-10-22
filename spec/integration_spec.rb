require_relative "../app"

RSpec.describe App do
  describe ".run" do
    it "includes only customers within 100km from Intercom's office order by user_id" do
      file = File.open("./spec/fixtures/customers.txt")

      expect(described_class.run(file).map(&:user_id)).to eq([12])
    ensure
      file.close
    end

    it "includes only customers within max distance from Intercom's office order by user_id" do
      file = File.open("./spec/fixtures/customers.txt")

      expect(described_class.run(file, max_distance: Float::INFINITY).map(&:user_id)).to eq([1, 12])
    ensure
      file.close
    end

    it "includes no customers if they are not max_distance from Intercom's office" do
      file = File.open("./spec/fixtures/customers.txt")

      expect(described_class.run(file, max_distance: 2).map(&:user_id)).to eq([])
    ensure
      file.close
    end
  end
end
