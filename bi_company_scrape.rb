require 'faraday'
require 'nokogiri'
require 'json'
require 'pry'
require './setup-capybara'

class BiCompanyScrape
  
  def initialize
    @browser = Capybara.current_session
  end
  
  def self.scrape
    scraper = BiCompanyScrape.new
    scraper.sign_on_and_setup
    scraper.scrape_company_urls
    # this is the part that visits the individual pages...
  end

  def sign_on_and_setup
    @browser.visit 'http://www.builtincolorado.com/companies#/companies'
    @browser.fill_in 'Email Address', with: 'jobseeker.fantastico@gmail.com'
    @browser.fill_in 'Password', with: 'my-cat-georgia'
    @browser.click_on 'Go!'
    sleep 5
    @browser.click_on 'Technology Company'
  end

  def scrape_company_urls(company_urls=[])
    sleep 10
    anchors = anchors_from_page
    urls = urls_from_anchors(anchors)
    company_urls.concat(urls)
    next_if_possible(company_urls)
  end

  def next_if_possible(company_urls)
    next_button = find_next_button
    next_button ? click_next_and_scrape(company_urls, next_button) : company_urls
  end

  def urls_from_anchors(anchors)
    anchors.map do |link|
      link['href']
    end
  end

  def anchors_from_page
    anchors = []
    @browser.within 'div.results.companies' do
      anchors = @browser.all 'a'
    end
    anchors
  end

  def find_next_button
    if @browser.has_css? 'li.pager-next'
      @browser.find 'li.pager-next'
    else
      nil
    end
  end

  def click_next_and_scrape(company_urls, next_button)
    next_button.click
    scrape_company_urls(company_urls)
  end
end

blah = BiCompanyScrape.scrape

binding.pry

"Something here to make pry work"
