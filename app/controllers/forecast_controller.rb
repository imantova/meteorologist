require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    require 'open-uri'
    url = "https://api.forecast.io/forecast/efaaa3e006ece1b26fe68e4432a803bf/#{@lat},#{@lng}"

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

    render("coords_to_weather.html.erb")
  end
end
