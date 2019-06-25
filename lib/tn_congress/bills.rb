# frozen_string_literal: true

class Bills
  attr_accessor :rep, :bill_number, :description, :last_action, :date

  @@all = []

  def initialize(hash, rep)
    hash.each do |key, val|
      send("#{key}=", val)
    end
    @@all << self
    Reps.add_bills(self, rep)
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
