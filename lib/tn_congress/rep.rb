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
    def find_rep(name)
      @@all.find { |rep| rep.name == name }
    end

    def find_or_create_rep(rep)
      Rep.new(rep) unless find_rep(rep[:name])
    end

    def all
      @@all
    end

    # gets the detail URL/bills URL of a member based on CLI input
    def rep_name_url(input)
      rep = @list.each_with_index.find { |_, index| index == input.to_i - 1 }
      rep[0].name_url
    end

    def rep_bills_url(input)
      rep = @list.each_with_index.find { |_, index| index == input.to_i - 1 }.flatten
      rep[0].bills_url
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
