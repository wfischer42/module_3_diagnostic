class Station

  def self.all_near(zipcode)
    # Connect to Faraday
    # Make API Call
    @api_response ||= get_all_stations_near(zipcode)
  end

  def name

  end

  private
    def self.get_all_stations()

    end
end
