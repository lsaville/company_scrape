require 'faraday'
require 'nokogiri'
require 'json'
require 'pry'

conn = Faraday.new(:url => 'http://www.techstars.com/companies/') do |faraday|
  faraday.request  :url_encoded             # form-encode POST params
  faraday.response :logger                  # log requests to STDOUT
  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
end
page = conn.get do |req|
  req.options.open_timeout = 10
end
p_page = Nokogiri::HTML(page.body)

binding.pry

"Something here to make pry work"
