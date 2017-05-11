# Defines the Beer class.
class BeerMe::Beer
  attr_accessor :name, :rank, :brewery, :style, :abv, :rating, :url
  attr_writer :description

# A class veriable called @@all that is equal to an empty array.
  @@all=[]

# Initializes with an argument of beer_hash.
# Adds the new beer to an array called @@all.
  def initialize(beer_hash)
    beer_hash.each { |key, value| self.send(("#{key}="), value) }
    @@all << self
  end

# Description equals description OR calls BeerMe Scraper to scrape beer from url.
  def description
    @description = @description || BeerMe::Scraper.scrape_description(self.url)
  end

# Scrapes beer info
  def self.find(id)
    self.all[id-1]
  end

# Calls @@all class veriable and make sure its not = to 0 and if it is calls Scraper to iterate and finally calls @@all again.
  def self.all
    if @@all.count==0
      BeerMe::Scraper.scrape_beers.each { |hash| BeerMe::Beer.new(hash) }
    end
    @@all
  end
end
