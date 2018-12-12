class Station

  def self.all_near(zipcode, limit: 10)
    @api_response ||= get_nearest_stations(location: zipcode, limit: limit)
  end

  def name

  end

  private
    def self.get_nearest_stations(params)
      params[:api_key] = ENV['NREL_API_KEY']
      url = "https://developer.nrel.gov/api/alt-fuel-stations/v1/"
      conn = Faraday.new(url: url)
      response = conn.get 'nearest.json', params

      parsed = JSON.parse(response.body, symbolize_names: true)
      station_data = parsed[:fuel_stations]
    end
end
