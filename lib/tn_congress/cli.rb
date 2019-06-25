# frozen_string_literal: true

class CLI
  attr_accessor :input, :rep

  BASE_PATH = "http://www.capitol.tn.gov"

  def call
    puts ""
    puts "Welcome to the TN Congress Directory!"
    index_data
    check_for_party
    more_info
    goodbye
  end

  def index_data
    puts <<-DOC

    Which branch of Congress are you interested in?
      Type 'house' to see a list of House representatives
      Type 'senate' to see a list of Senators

    DOC
    @input = gets.strip.downcase
    if @input == "house"
      selection = Scraper.scrape_all_reps(BASE_PATH + "/house/members/")
      Reps.create_from_selection(selection)
    elsif @input == "senate"
      selection = Scraper.scrape_all_reps(BASE_PATH + "/senate/members/")
      Reps.create_from_selection(selection)
    else
      puts ""
      puts "I don't understand. Try again?"
      index_data
    end
  end

  def check_for_party
    puts <<-DOC

    Are you interested in a specific party? Put 'D' to see all Democrats, 'R' for Republicans, or 'All' to see everyone."

    DOC
    answer = gets.strip.upcase
    puts ""
    if answer == "D"
      Reps.print_reps(answer)
    elsif answer == "R"
      Reps.print_reps(answer)
    elsif answer == "ALL"
      Reps.print_reps(answer)
    else
      puts "I don't understand. Please try again!"
      check_for_party
    end
  end

  def more_info
    puts ""
    puts "Enter in the number of any member of Congress you'd like to learn more about!"
    @rep = gets.strip
    puts <<-DOC

    Type 'bio' for more info about this representative, or type 'bills' to see recent bills they've sponsored!"

    DOC
    answer = gets.strip.downcase
    if answer == "bio"
      detail = Reps.rep_name_url(@rep)
      if @input == "house"
        info = Scraper.scrape_details(BASE_PATH + "/house/members/" + detail)
      elsif @input == "senate"
        info = Scraper.scrape_details(BASE_PATH + "/senate/members/" + detail)
      end
      puts ""
      Reps.print_info(info)
    elsif answer == "bills"
      detail = Reps.rep_bills_url(@rep)
      bills = Scraper.scrape_bills(detail)
      Bills.add_bill(bills, @rep)
      Bills.print_bills
    else
      puts ""
      puts "I don't understand. Please try again!"
      more_info
    end
  end

  def goodbye
    puts ""
    puts "Thanks for learning more about your representatives!"
  end
end
