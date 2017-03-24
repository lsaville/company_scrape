require 'faraday'
require 'nokogiri'
require 'json'
require 'pry'

page = Faraday.get('http://www.builtincolorado.com/companies')

Pry.start(binding)
