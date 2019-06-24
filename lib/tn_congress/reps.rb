class TnCongress::Reps

  attr_accessor :all, :email, :name, :name_url, :party, :bills_url, :phone, :district, :bills

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

end
