require 'rails_helper'

RSpec.feature "StationSearch", type: :feature do
  # As a user
  # When I visit "/"
  # And I fill in the search form with 80203 (Note: Use the existing search form)
  # And I click "Locate"
  # Then I should be on page "/search"
  # Then I should see a list of the 10 closest stations within 6 miles sorted by distance
  # And the stations should be limited to Electric and Propane
  # And for each of the stations I should see Name, Address, Fuel Types, Distance, and Access Times
  context "When a user searches for stations by zip code" do
    scenario "the user sees 10 closest stations sorted by distance" do
      visit '/'

      within(".navbar") do
        fill_in 'zipcode', with: '80203'
        click_on "Locate"
      end

      expect(page.current_path).to include(search_path)
      within(".results") do
        results = all('.result')
        expect(result.first).to have_content("Name: ")
        expect(result.first).to have_content("Address: ")
        expect(result.first).to have_content("Fuel Type: ")
        expect(result.first).to have_content("Distance: ")
        expect(result.first).to have_content("Access Times: ")
        expect(result.count).to eq(10)
      end
    end
  end
end
