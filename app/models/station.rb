class Station
  attr_reader :fuel_type, :distance, :access_time

  FUEL_TYPES = { "ELEC" => "Electric Charging Station",
                 "LPG" => "Liquefied Petroleum Gas (Propane)"}

  # TODO: (Refactor) Setup accessor methods instead of using instance vars.
  def initialize(data)
    @data = data
  end

  def name
    @data[:station_name]
  end

  def address
    [@data[:street_address],
    @data[:city],
    @data[:state],
    @data[:zip]].join(', ')
  end

  def fuel_type
    FUEL_TYPES[@data[:fuel_type_code]]
  end

  def distance
    @data[:distance].round(1).to_s + " miles from you"
  end

  def access_time
    @data[:access_days_time]
  end

  def self.all_near(zipcode, limit: 10)
    @api_response ||= NerlService.get_nearest_stations(location: zipcode, limit: limit)
    @stations ||= @api_response.map do |station_data|
      Station.new(station_data)
    end
  end
end
