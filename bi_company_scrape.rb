require 'faraday'
require 'nokogiri'
require 'json'
require 'pry'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end

Capybara.default_driver = :poltergeist

browser = Capybara.current_session
browser.visit 'http://www.builtincolorado.com/companies#/companies'
browser.fill_in 'Email Address', with: 'jobseeker.fantastico@gmail.com'
browser.fill_in 'Password', with: 'my-cat-georgia'
browser.click_on 'Go!'
sleep 3
browser.click_on 'Technology Company'

sleep 3
links = []
browser.within 'div.results.companies' do
  links = browser.all 'a'
end

company_urls = []
links.each do |link|
  company_urls << link['href']
end

next_button = browser.find 'li.pager-next'
binding.pry
next_button.click

binding.pry

"Something here to make pry work"
