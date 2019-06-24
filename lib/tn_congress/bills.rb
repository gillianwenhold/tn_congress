class TnCongress::Bills

  attr_accessor :rep, :number, :description, :last_action, :date

  def initialize(hash)
    hash.each do |key, val|
      self.send("#{key}=", val)
    end
    TnCongress::Reps.add_bills(self)
  end

end
