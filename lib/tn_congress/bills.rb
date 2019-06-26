# frozen_string_literal: true

class Bills
  attr_reader :rep, :bill_number, :description, :last_action, :date

  @@all = []

  def initialize(bill_number:, description:, last_action:, date:)
    @bill_number = bill_number
    @description = description
    @last_action = last_action
    @date = date
    @@all << self
  end

  def self.add_bill(bills, rep)
    bills.each do |bill|
      new(bill, rep)
    end
  end

  def self.print_bills
    @@all.sort_by(&:bill_number)[0..10].each do |bill|
      puts <<-DOC
      ------------------- #{bill.bill_number} -------------------
      #{bill.description}

      Date: #{bill.date}
      Last Action: #{bill.last_action}

      DOC
    end
  end

  def self.all
    @@all
  end
end
