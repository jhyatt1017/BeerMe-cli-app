# First defines the CLI class thats responsible for all the input and output.
class BeerMe::CLI

# Displays menu and asking for input from user
  def self.start
    menu
    get_input
  end

# Puts menu for user to pick which beer they'd like more info about.
  def self.menu
    puts "BeerAdvocate.com's Top 10 Beers of All Time"
    puts "-------------------------------------------"
    BeerMe::Beer.all.each do |beer|
      puts "#{beer.rank}. #{beer.name}, #{beer.style}, #{beer.rating}"
    end
    puts "-------------------------------------------"
  end

# Gets input from user.
# If user knows what they would like to choose from it lists the beer.
# If user picks number between 1 & 10 and prints input.
# If user types exit, the program will close.
# If user types something other than '1-10', 'list' or 'exit' will notify user again what to choose from.
  def self.get_input
    input=nil
    until input=='exit'
      puts "Please enter a number for details, 'list' to review the top ten, or 'exit' to quit."
      input = gets.strip.downcase
      if input == 'list'
        menu
      elsif input.to_i.between?(1,10)
        show_beer_details(input)
      elsif input == 'exit'
        goodbye
      else
        puts "I don't recognize that command.  Please try again."
      end
    end
  end

# Puts out info about chosen beer.
  def self.show_beer_details(selection)
    beer = BeerMe::Beer.find(selection.to_i)
    puts ""
    puts "Name: #{beer.name}"
    puts "Brewed by: #{beer.brewery}"
    puts "Style: #{beer.style} #{beer.abv}"
    puts "Description: #{beer.description}"
    puts ""
  end

# Goodbye message when user exits program.
  def self.goodbye
    puts ""
    puts "Thanks for stopping by! Don't drink them all in one night!"
  end
end
