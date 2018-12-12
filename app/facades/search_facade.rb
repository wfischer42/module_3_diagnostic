class SearchFacade
  def initialize(params)
    @zipcode = params["zipcode"]
  end

  def stations
    Station.all_near(@zipcode)
  end
end
