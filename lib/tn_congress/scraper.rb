require "pry"
require "nokogiri"
require "open-uri"

class TnCongress::Scraper

  attr_accessor :scraped_reps

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

  def self.get_all_reps(url)
    doc = Nokogiri::HTML(open(url))
    @scraped_reps = []
    tables = doc.search("table")
    tables.search("tr")[1..-1].each do |tr|
      @scraped_reps << {
        :email => tr.search("td[1] a.icon-mail").attribute("href").value.gsub("mailto:",""),
        :name => tr.search("td[2]").text,
        :name_url => tr.search("td[2] a").attribute("href").value,
        :party => tr.search("td[3]").text,
        :bills_url => tr.search("td[4] a").attribute("href").value,
        :district => tr.search("td[5] a").text,
        :phone => tr.search("td[7]").text
      }
    end
    @scraped_reps
  end

end
