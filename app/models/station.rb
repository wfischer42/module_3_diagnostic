class Station
  attr_reader :name, :address, :fuel_type, :distance, :access_time

  FUEL_TYPES = { "ELEC" => "Electric Charging Station",
                 "LPG" => "Liquefied Petroleum Gas (Propane)"}

  # TODO: (Refactor) Setup accessor methods instead of using instance vars.
  def initialize(data)
    @name = data[:station_name]
    @address = [data[:street_address],
                data[:city],
                data[:state],
                data[:zip]].join(', ')
    @fuel_type = FUEL_TYPES[data[:fuel_type_code]]
    @distance = data[:distance].round(1).to_s + " miles from you"
    @access_time = data[:access_days_time]
  end

  def self.all_near(zipcode, limit: 10)
    @api_response ||= get_nearest_stations(location: zipcode, limit: limit)
    @stations ||= @api_response.map do |station_data|
      Station.new(station_data)
    end
  end

  private
    # TODO: Refactor - Move method into service.
    def self.get_nearest_stations(params)
      params[:api_key] = ENV['NREL_API_KEY']
      params[:fuel_type] = "LPG,ELEC"
      url = "https://developer.nrel.gov/api/alt-fuel-stations/v1/"
      conn = Faraday.new(url: url)
      response = conn.get 'nearest.json', params

      parsed = JSON.parse(response.body, symbolize_names: true)
      station_data = parsed[:fuel_stations]
    end
end
