# frozen_string_literal: true

require_relative "./app/location"
require_relative "./app/customer"

class App
  def self.run(file, max_distance: 100)
    intercom_office = Location.new(53.339428, -6.25766)

    customers = Customer
                .load_from_file(file)
                .select { |customer| intercom_office.distance_from(customer.location) <= max_distance }
                .sort

    puts "We can invite up to #{customers.size} customers"
    puts "-----------------------------------------------"
    customers.each { |customer| puts "#{customer.name} with id: #{customer.user_id}" }
  end
end
