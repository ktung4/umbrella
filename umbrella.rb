require "dotenv/load"
require "http"
require "json"

pp "Where are you?"

user_location = gets.chomp
#user_location = "Chicago"

pp user_location

maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY")

resp = HTTP.get (maps_url)

raw_response = resp.to_s

parse_response = JSON.parse(raw_response)

results = parse_response.fetch("results")

first_result = results.at(0)

geo = first_result.fetch("geometry")

loc = geo.fetch("location")

pp latitude = loc.fetch("lat")

pp longitude = loc.fetch("lng")

# require "http"

# pirate_weather_api_key=ENV.fetch("PIRATE_WEATHER_KEY")

# pirate_weather_url = "https://apipirateweather.net/forecast/"+pirate_weather_api_key+"/41.8887,-87.6355"

# raw_response = HTTP.get(pirate_weather_url)

# require "json"
