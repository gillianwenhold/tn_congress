class TnCongress::Scraper

  def self.get_all_senators
    return [
      {name: "Akbari, Raumesh", party: "D", district: "District 29", phone: "(615) 741-1767"},
      {name: "Bailey, Paul", party: "R", district: "District 15", phone: "(615) 741-3978"}
    ]
  end

  def self.get_all_house_reps
    return [
      {name: "Baum, Charlie", party: "R", district: "District 37", phone: "(615) 741-6849"},
      {name: "Beck, Bill", party: "D", district: "District 51", phone: "(615) 741-3229"}
    ]
  end

end
