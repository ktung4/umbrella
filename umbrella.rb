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

pirate_weather_api_key=ENV.fetch("PIRATE_WEATHER_KEY")
pirate_weather_url = "https://api.pirateweather.net/forecast/"+pirate_weather_api_key+"/"+latitude.to_s+","+longitude.to_s
raw_response_pirate = HTTP.get(pirate_weather_url)
parse_response_pirate = JSON.parse(raw_response_pirate)
results_pirate = parse_response_pirate.fetch("currently")
current_temp = results_pirate.fetch("temperature")
puts "It is currently #{current_temp}°F."
minutely_hash = parse_response_pirate.fetch("minutely", false)
if minutely_hash
  next_hour_summary = minutely_hash.fetch("summary")

  puts "Next hour: #{next_hour_summary}"
end

# raw_pirate_weather_data = HTTP.get(pirate_weather_url)
# parsed_pirate_weather_data = JSON.parse(raw_pirate_weather_data)
# currently_hash = parsed_pirate_weather_data.fetch("currently")
# current_temp = currently_hash.fetch("temperature")
# puts "It is currently #{current_temp}°F."
# # Some locations around the world do not come with minutely data.
# minutely_hash = parsed_pirate_weather_data.fetch("minutely", false)
# if minutely_hash
#   next_hour_summary = minutely_hash.fetch("summary")

#   puts "Next hour: #{next_hour_summary}"
# end

hourly_hash = parse_response_pirate.fetch("hourly")
hourly_data_array = hourly_hash.fetch("data")
next_twelve_hours = hourly_data_array[1..12]
precip_prob_threshold = 0.10
any_precipitation = false
next_twelve_hours.each do |hour_hash|
  precip_prob = hour_hash.fetch("precipProbability")

  if precip_prob > precip_prob_threshold
    any_precipitation = true
    precip_time = Time.at(hour_hash.fetch("time"))
    seconds_from_now = precip_time - Time.now
    hours_from_now = seconds_from_now / 60 / 60
    puts "In #{hours_from_now.round} hours, there is a #{(precip_prob * 100).round}% chance of precipitation."
  end
end

if any_precipitation == true
  puts "You might want to take an umbrella!"
else
  puts "You probably won't need an umbrella."
end

#https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY")
# require "http"
# pirate_weather_api_key=ENV.fetch("PIRATE_WEATHER_KEY")
# pirate_weather_url = "https://apipirateweather.net/forecast/"+pirate_weather_api_key+"/41.8887,-87.6355"
# raw_response = HTTP.get(pirate_weather_url)

# require "json"
