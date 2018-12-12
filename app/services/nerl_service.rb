class NerlService
  def self.get_nearest_stations(params)
    parse response(params)
  end

  private
    def self.api_params(params)
      params[:api_key] = ENV['NREL_API_KEY']
      params[:fuel_type] = "LPG,ELEC"
      return params
    end

    def self.response(params)
      url = "https://developer.nrel.gov/api/alt-fuel-stations/v1/"
      conn = Faraday.new(url: url)
      conn.get 'nearest.json', api_params(params)
    end

    def self.parse(response)
      parsed = JSON.parse(response.body, symbolize_names: true)
      station_data = parsed[:fuel_stations]
    end
end
