class TnCongress::Reps

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

  def self.add_bills(bill)
    @bills << bill
    bill.rep = self
  end

  def self.all
    @@all
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

  # gets the detail URL of a member based on CLI input
  def self.get_name_url(input)
    @rep = @list.each_with_index.find{|rep, index| index == input.to_i-1 }
    @new = @rep.to_s.split("@")[4].gsub("name_url=\"", "").gsub("\", ", "")
  end

  def self.get_bills_url(input)
      @rep = @list.each_with_index.find{|rep, index| index == input.to_i-1 }
    @new = @rep.to_s.split("@")[6].gsub("bills_url=\"", "").gsub("\", ", "")
  end

end
