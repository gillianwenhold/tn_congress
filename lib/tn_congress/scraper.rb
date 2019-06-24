require "pry"
require "nokogiri"
require "open-uri"

class TnCongress::Scraper

  attr_accessor :scraped_reps

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
