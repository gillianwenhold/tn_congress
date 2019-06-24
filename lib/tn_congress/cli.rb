class TnCongress::CLI

  attr_accessor :reps, :input

  BASE_PATH = "http://www.capitol.tn.gov"

  def call
    puts ""
    puts "Welcome to the TN Congress Directory!"
    get_index_data
    check_for_party
    get_more_info
    goodbye
  end

  def get_index_data
    puts <<-DOC

    Which branch of Congress are you interested in?
      Type 'house' to see a list of House representatives
      Type 'senate' to see a list of Senators
      Type 'exit' to quit :(

    DOC
    @input = gets.strip.downcase
    if @input == "house"
      selection = TnCongress::Scraper.get_all_reps(BASE_PATH + "/house/members/")
      TnCongress::Reps.create_from_selection(selection)
    elsif @input == "senate"
      selection = TnCongress::Scraper.get_all_reps(BASE_PATH + "/senate/members/")
      TnCongress::Reps.create_from_selection(selection)
    elsif @input == "exit"
      return
    else
      puts "I don't understand. Try again?"
    end
  end

  def check_for_party
    puts ""
    puts "Are you interested in a specific party? Put 'D' to see all Democrats, 'R' for Republicans, or 'All' to see everyone."
    puts ""
    answer = gets.strip.upcase
    puts ""
    TnCongress::Reps.print_reps(answer)
  end

  def get_more_info

    puts ""
    puts "Enter in the number of any member of Congress you'd like to learn more about! Or type 'exit' to quit the program :("
    answer = gets.strip
    puts ""
    puts "Type 'bio' for personal info about this representative, or type 'bills' for info about bills they've sponsored!"
    answer2 = gets.strip.downcase

    if answer2 == "bio"
      detail = TnCongress::Reps.get_name_url(answer)
      if @input == "house"
        TnCongress::Scraper.get_details(BASE_PATH + "/house/members/" + detail)
      elsif @input == "senate"
        TnCongress::Scraper.get_details(BASE_PATH + "/senate/members/" + detail)
      end
    elsif answer2 == "bills"
      detail = TnCongress::Reps.get_bills_url(answer)
      TnCongress::Scraper.get_bills(detail)
    end

  end

  def goodbye
    puts "Thanks for learning more about your representatives!"
  end

end



=begin

URLS
  Senate Members: http://www.capitol.tn.gov/senate/members/
  House Members: http://www.capitol.tn.gov/house/members/

CLI

  GET: Ask user which branch of congress they're interested in - House or Senate?

  DO: Use scraper to make lists of reps based on which branch they're interested in
    = If Senate, scrape url: http://www.capitol.tn.gov/senate/members/
    = if House, scrape url: http://www.capitol.tn.gov/house/members/

  GET: Ask user which party they're interested in: Democratic, Republican, or All

  SHOW: List all members with that filter set
    :name, :party, :email, :phone, :district
    (hash also includes :personal_url, :bills_url)

  GET: Type the number of a rep they'd like to see more information about (input_1)

  GET: Ask user if they want to see personal information or bills they've sponsored (input_2)

  DO: Use scraper to create detail pages for selected rep using the url for their personal info or bills sponsored based on what they want

  SHOW: List of info
    = Personal - :personal_info, :committees, :community_involvement, :honors
    = Bills - :bill_url, :bill_id, :info, :last_action, :date

=end
