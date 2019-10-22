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
    print_customers(customers)
  rescue Customer::ParsingError, Location::Invalid => e
    print_error(e)
  end

  def self.print_error(error)
    puts "There seems to be an issue with the file specified"
    puts "Please run --help to see the format of the file we are expecting"
    puts "\n"
    puts "Error"
    puts "------"
    puts error.message
    puts "\n"
  end

  def self.print_customers(customers)
    if customers.size.zero?
      puts "We cannot invite anybody :("
    else
      puts "We can invite up to #{customers.size} customers"
      puts "-----------------------------------------------"
      customers.each { |customer| puts "#{customer.name} with id: #{customer.user_id}" }
    end

    customers
  end
end
