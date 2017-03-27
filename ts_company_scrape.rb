require 'faraday'
require 'nokogiri'
require 'json'
require 'pry'

page = Faraday.get('http://www.techstars.com/companies/')

p_page = Nokogiri::HTML(page.body)

binding.pry

"Something here to make pry work"
