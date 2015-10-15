require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    require "open-uri"

    url = "https://maps.googleapis.com/maps/api/geocode/json?address=url_safe_street_address" + url_safe_street_address

    raw_data = open(url).read

    require "JSON"

    parsed_data = JSON.parse(raw_data)

    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    require 'open-uri'
    url = "https://api.forecast.io/forecast/efaaa3e006ece1b26fe68e4432a803bf/#{@latitude},#{@longitude}"

    require 'json'

    parsed_data = JSON.parse(open(url).read)

    currently = parsed_data["currently"]

    @current_temperature = currently["temperature"]

    @current_summary = currently["summary"]

    minutely = parsed_data["minutely"]

    @summary_of_next_sixty_minutes = minutely["summary"]

    hourly = parsed_data["hourly"]

    @summary_of_next_several_hours = hourly["summary"]

    daily = parsed_data["daily"]

    @summary_of_next_several_days = daily["summary"]

    render("street_to_weather.html.erb")
  end
end
