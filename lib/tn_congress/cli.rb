class TnCongress::CLI

  attr_accessor :input, :rep

  BASE_PATH = "http://www.capitol.tn.gov"

  def call
    puts ""
    puts "Welcome to the TN Congress Directory!"
    @again = nil
    while @again != 'exit'
      get_index_data
      check_for_party
      get_more_info
      again?
    end
    goodbye
  end

  def get_index_data
    puts <<-DOC

    Which branch of Congress are you interested in?
      Type 'house' to see a list of House representatives
      Type 'senate' to see a list of Senators

    DOC
    @input = gets.strip.downcase
    if @input == "house"
      selection = TnCongress::Scraper.get_all_reps(BASE_PATH + "/house/members/")
      TnCongress::Reps.create_from_selection(selection)
    elsif @input == "senate"
      selection = TnCongress::Scraper.get_all_reps(BASE_PATH + "/senate/members/")
      TnCongress::Reps.create_from_selection(selection)
    else
      puts ""
      puts "I don't understand. Try again?"
      get_index_data
    end
  end

  def check_for_party
    puts ""
    puts "Are you interested in a specific party? Put 'D' to see all Democrats, 'R' for Republicans, or 'All' to see everyone."
    puts ""
    answer = gets.strip.upcase
    puts ""
    if answer == "D"
      TnCongress::Reps.print_reps(answer)
    elsif answer == "R"
      TnCongress::Reps.print_reps(answer)
    elsif answer == "ALL"
      TnCongress::Reps.print_reps(answer)
    else
      puts "I don't understand. Please try again!"
      check_for_party
    end
  end

  def get_more_info

    puts ""
    puts "Enter in the number of any member of Congress you'd like to learn more about!"
    @rep = gets.strip
    puts ""
    puts "Type 'bio' for more info about this representative, or type 'bills' to see recent bills they've sponsored!"
    puts ""
    answer = gets.strip.downcase

    if answer == "bio"
      detail = TnCongress::Reps.get_name_url(@rep)
      if @input == "house"
        info = TnCongress::Scraper.get_details(BASE_PATH + "/house/members/" + detail)
      elsif @input == "senate"
        info = TnCongress::Scraper.get_details(BASE_PATH + "/senate/members/" + detail)
      end
      puts ""
      TnCongress::Reps.print_info(info)
    elsif answer == "bills"
      detail = TnCongress::Reps.get_bills_url(@rep)
      bills = TnCongress::Scraper.get_bills(detail)
      TnCongress::Bills.add_bill(bills, @rep)
      TnCongress::Bills.print_bills
    else
      puts ""
      puts "I don't understand. Please try again!"
      get_more_info
    end

  end

  def again?
    puts "For more info, type 'again'. Or type 'exit' to quit!"
    @again = gets.strip.downcase
  end

  def goodbye
    puts ""
    puts "Thanks for learning more about your representatives!"
    puts ""
  end

end
