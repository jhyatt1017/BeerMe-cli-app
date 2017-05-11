#Defines Scrpaer Class.
class BeerMe::Scraper
  ROOT_URL = "https://www.beeradvocate.com"

# Scrape_beers accepts an argument of the starting beers to scrape,
# and modify cli to permit user to choose what beer out of the top ten they would like more info about.
  def self.scrape_beers
    doc = Nokogiri::HTML(open(ROOT_URL+'/lists/top/'))
    rows = doc.css('#ba-content table tr')
    results = (3..12).collect {|index| parse_row(rows[index-1])}
  end

# Picks out the desendants of the row in which is selected
  def self.parse_row(row)
    {
      name: row.children[1].children[0].children[0].children[0].text,
      brewery: row.children[1].children[1].children[0].text,
      style: row.children[1].children[1].children[2].text,
      abv: row.children[1].children[1].children[3].text,
      rank: row.children[0].text,
      url: row.children[1].children[0].attribute("href").value,
      rating: row.children[2].children[0].text
    }
  end

# Instances of the Beer class when the beer’s description is requested.
  def self.scrape_description(url)
    doc = Nokogiri::HTML(open(ROOT_URL+url))
    text = doc.css('#ba-content > div:nth-child(4) > div:nth-child(2)').text
    description = text.split("\n")[19].split(/(.*)Added by.*/)[1].strip
  end
end
