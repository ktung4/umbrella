require "http"

pirate_weather_api_key=ENV.fetch("PIRATE_WEATHER_KEY")

pirate_weather_url = "https://apipirateweather.net/forecast/"+pirate_weather_api_key+"/41.8887,-87.6355"
