require "dotenv/load"
require "http"
require "json"
pp ENV.fetch("GMAPS_KEY")
pp ENV.fetch("OPENAI_KEY")
pp ENV.fetch("PIRATE_WEATHER_KEY")
