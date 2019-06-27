# frozen_string_literal: true

class Bill
  attr_reader :bill_number, :description, :last_action, :date

  def self.print_bills(info)
    info[0..10].each do |bill|
      puts <<-DOC
      ------------------- #{bill[:bill_number]} -------------------
      #{bill[:description]}

      Date: #{bill[:date]}
      Last Action: #{bill[:last_action]}

      DOC
    end
  end
end
