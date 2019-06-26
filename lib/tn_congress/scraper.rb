# frozen_string_literal: true

require "pry"
require "nokogiri"
require "open-uri"

class Scraper
  attr_accessor :scraped_reps, :scraped_bills

  class << self
    def scrape_all_reps(url)
      doc = Nokogiri::HTML(open(url))
      tables = doc.search("table")
      tables.search("tr")[1..-1].each do |tr|
        Rep.new(
          email: tr.search("td[1] a.icon-mail").attribute("href").value.gsub("mailto:", ""),
          name: tr.search("td[2]").text,
          name_url: tr.search("td[2] a").attribute("href").value,
          party: tr.search("td[3]").text,
          bills_url: tr.search("td[4] a").attribute("href").value,
          district: tr.search("td[5] a").text,
          phone: tr.search("td[7]").text
        )
      end
      Rep.all
    end

    def scrape_details(url)
      doc = Nokogiri::HTML(open(url))
      doc.css("ul.tabs-container ul.list-rows").text.strip.split(/\s\s\s+/)
    end

    def scrape_bills(url)
      doc = Nokogiri::HTML(open(url))
      tables = doc.search("table#TabContainer1_tabBillsSponsored_gvBillsSponsored")
      tables.search("tr.items").each do |tr|
        Bill.new(
          bill_number: tr.search("td[1] a").text,
          description: tr.search("td[2]").text,
          last_action: tr.search("td[3]").text,
          date: tr.search("td[4]").text
        )
      end
      @scraped_bills
    end
  end
end
