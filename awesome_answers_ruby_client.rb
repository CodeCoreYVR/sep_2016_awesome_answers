require 'faraday'
require 'json'

API_KEY = '7aa2d45e2654b6226249f940feeaec265410142c8edc6b672abde1be1d9d2110'

conn = Faraday.new(url: 'http://localhost:3000') do |faraday|
  faraday.request  :url_encoded             # form-encode POST params
  faraday.response :logger                  # log requests to STDOUT
  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
end

# this will make a GET request to: 'http://localhost:3000/api/v1/questions'
response = conn.get "/api/v1/questions?api_key=#{API_KEY}"
parsed_body = JSON.parse(response.body) # this should give us an array

parsed_body.each do |question_hash|
  puts question_hash['title']
end
