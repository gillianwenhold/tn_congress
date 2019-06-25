class Reps

  attr_accessor :all, :email, :name, :name_url, :party, :bills_url, :phone, :district, :bills, :list, :rep, :new

  @@all = []

  def initialize(hash)
    hash.each do |key, val|
      self.send("#{key}=", val)
    end
    @bills = []
    @@all << self
  end

  def self.create_from_selection(selection)
    selection.each do |rep|
      self.new(rep)
    end
  end

  def self.add_details(details)
    details.each do |key, val|
      self.send("#{key}=", val)
    end
  end

  def self.add_bills(bill, rep)
    bill.rep = self.all.each_with_index.find{|r, index| index == rep.to_i-1}
  end

  def self.all
    @@all
  end

  # gets the detail URL/bills URL of a member based on CLI input
  def self.get_name_url(input)
    @rep = @list.each_with_index.find{|rep, index| index == input.to_i-1 }
    @new = @rep.to_s.split("@")[4].gsub("name_url=\"", "").gsub("\", ", "")
  end

  def self.get_bills_url(input)
      @rep = @list.each_with_index.find{|rep, index| index == input.to_i-1 }
    @new = @rep.to_s.split("@")[6].gsub("bills_url=\"", "").gsub("\", ", "")
  end

  # prints list of reps based on CLI input
  def self.print_reps(input)
    if input != "ALL"
      @list = @@all.select {|rep| rep.party.strip == "#{input}"}
    else
      @list = @@all
    end
    @list.each_with_index do |rep, index|
      puts "#{index+1}. #{rep.name} - Party: #{rep.party.rstrip}, #{rep.district}, Phone: #{rep.phone}"
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
