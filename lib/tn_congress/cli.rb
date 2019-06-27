# frozen_string_literal: true

class CLI
  attr_accessor :input, :rep

  BASE_PATH = "http://www.capitol.tn.gov"

  def call
    puts ""
    puts "Welcome to the TN Congress Directory!"
    while @answer != "exit"
      index_data
      check_for_party
      more_info
      again?
    end
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
      Scraper.scrape_all_reps(BASE_PATH + "/house/members/")
    elsif @input == "senate"
      Scraper.scrape_all_reps(BASE_PATH + "/senate/members/")
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
    if answer != "D" && answer != "R" && answer != "ALL"
      puts "I don't understand. Please try again!"
      check_for_party
    else
      Rep.print_reps(answer)
    end
  end

  def more_info
    puts ""
    puts "Enter in the number of any member of Congress you'd like to learn more about!"
    rep = gets.strip
    puts <<-DOC

    Type 'bio' for more info about this representative, or type 'bills' to see recent bills they've sponsored!"

    DOC
    answer = gets.strip.downcase
    if answer == "bio"
      bio_answer(rep)
    elsif answer == "bills"
      detail = Rep.rep_bills_url(rep)
      Scraper.scrape_bills(detail)
      Bill.print_bills
    else
      puts ""
      puts "I don't understand. Please try again!"
      more_info
    end
  end

  def again?
    puts "Type 'again' to learn about another representative. Or type 'exit' to quit the program."
    puts ""
    @answer = gets.strip
    puts ""
  end

  def goodbye
    puts "Thanks for learning more about your representatives!"
  end

  def bio_answer(rep)
    detail = Rep.rep_name_url(rep)
    if @input == "house"
      info = Scraper.scrape_details(BASE_PATH + "/house/members/" + detail)
    elsif @input == "senate"
      info = Scraper.scrape_details(BASE_PATH + "/senate/members/" + detail)
    end
    puts ""
    Rep.print_info(info)
  end
end
