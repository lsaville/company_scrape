require 'faraday'
require 'nokogiri'
require 'json'
require 'pry'

page = Faraday.get('http://www.builtincolorado.com/companies')

p_page = Nokogiri::HTML(page.body)

link_fragments = p_page.css('.views-content .views-field-title a').map do |link|
  link['href']
end

binding.pry

"Something here to make pry work"
