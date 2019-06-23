class TnCongress::Reps

  attr_accessor :all, :name, :party, :email, :phone, :district

  @@all = []

  def initialize(hash)
    hash.each do |key, val|
      self.send("#{key}=", val)
    end
    @@all << self
  end

  def self.create_from_selection(selection)
    selection.each do |event|
      self.new(event)
    end
  end

  def self.add_details(details)
    details.each do |key, val|
      self.send("#{key}=", val)
    end
  end

  def self.all
    @@all
  end

end
