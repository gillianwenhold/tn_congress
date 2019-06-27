# frozen_string_literal: true

class Rep
  attr_reader :email, :name, :name_url, :party, :bills_url,
              :phone, :district, :bills, :list, :rep

  @@all = []

  def initialize(email:, name:, name_url:, party:, bills_url:, phone:, district:)
    @email = email
    @name = name
    @name_url = name_url
    @party = party
    @bills_url = bills_url
    @phone = phone
    @district = district
    @bills = []
    @@all << self
  end

  class << self
  # def find

    def add_bills(bill, rep)
      bill.rep = all.each_with_index.find { |_, index| index == rep.to_i - 1 }
    end

    def all
      @@all
    end

    # gets the detail URL/bills URL of a member based on CLI input
    def rep_name_url(input)
      rep = @list.each_with_index.find { |_, index| index == input.to_i - 1 }
      rep.to_s.split("@")[4].gsub("name_url=\"", "").gsub("\", ", "")
    end

    def rep_bills_url(input)
      rep = @list.each_with_index.find { |_, index| index == input.to_i - 1 }
      rep.to_s.split("@")[6].gsub("bills_url=\"", "").gsub("\", ", "")
    end

    # prints list of reps based on CLI input
    def print_reps(input)
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
    def print_info(info)
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
end
