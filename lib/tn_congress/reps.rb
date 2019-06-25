# frozen_string_literal: true

class Reps
  attr_accessor :all, :email, :name, :name_url, :party, :bills_url
  attr_accessor :phone, :district, :bills, :list, :rep, :new

  @@all = []

  def initialize(hash)
    hash.each do |key, val|
      send("#{key}=", val)
    end
    @bills = []
    @@all << self
  end

  def self.create_from_selection(selection)
    selection.each do |rep|
      new(rep)
    end
  end

  def self.add_details(details)
    details.each do |key, val|
      send("#{key}=", val)
    end
  end

  def self.add_bills(bill, rep)
    bill.rep = all.each_with_index.find { |_, index| index == rep.to_i - 1 }
  end

  def self.all
    @@all
  end

  # gets the detail URL/bills URL of a member based on CLI input
  def self.rep_name_url(input)
    @rep = @list.each_with_index.find { |_, index| index == input.to_i - 1 }
    @new = @rep.to_s.split("@")[4].gsub("name_url=\"", "").gsub("\", ", "")
  end

  def self.rep_bills_url(input)
    @rep = @list.each_with_index.find { |_, index| index == input.to_i - 1 }
    @new = @rep.to_s.split("@")[6].gsub("bills_url=\"", "").gsub("\", ", "")
  end

  # prints list of reps based on CLI input
  def self.print_reps(input)
    @list = if input != "ALL"
              @@all.select { |rep| rep.party.strip == input.to_s }
            else
              @@all
            end
    @list.each_with_index do |rep, index|
      puts <<-DOC
      #{index + 1}. #{rep.name} - Party: #{rep.party.rstrip}, #{rep.district}
          Phone: #{rep.phone}, Email: #{rep.email}
      DOC
    end
  end

  # prints info from bio
  def self.print_info(info)
    bio = []
    committees = []
    info.each do |li|
      if li.include?("ommittee")
        committees << li
      else
        bio << li
      end
    end
    puts "---------------------- Personal Bio ----------------------"
    bio.each do |li|
      puts li
    end
    puts ""
    puts "------------------------ Committees ------------------------"
    committees.each do |li|
      puts li
    end
    puts ""
  end
end
