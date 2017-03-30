require 'faraday'
require 'nokogiri'
require 'json'
require 'pry'
require 'capybara/poltergeist'

# preamble
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end

Capybara.default_driver = :poltergeist

@browser = Capybara.current_session
@browser.visit 'http://www.builtincolorado.com/companies#/companies'
@browser.fill_in 'Email Address', with: 'jobseeker.fantastico@gmail.com'
@browser.fill_in 'Password', with: 'my-cat-georgia'
@browser.click_on 'Go!'
sleep 5
@browser.click_on 'Technology Company'

def scrape_company_urls(company_urls=[])
  sleep 5
  pagination = @browser.find 'li.pager-current'
  page_num = pagination.text.to_i
  puts "I'm on page #{page_num + 1}"
  links = []
  @browser.within 'div.results.companies' do
    links = @browser.all 'a'
  end

  links.each do |link|
    company_urls << link['href']
  end
  puts "Finished with this page on to #{page_num + 2}"
  puts "There have been #{company_urls.count} company urls gathered"
  next_button = find_next_button
  next_button ? click_next_and_scrape(company_urls, next_button) : company_urls
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

blah = scrape_company_urls

binding.pry

"Something here to make pry work"
