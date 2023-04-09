require 'rails_helper'

RSpec.describe 'contestant index', type: :feature do

  describe 'User Story 2 When I visit the contestants index page ("/contestants")' do
    it "I see a list of names of all the contestants and under each name lists of the projects (names) that they've been on" do
      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
      furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

      news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
      boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
      upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")

      jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
      gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
      erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)

      ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
      ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
      ContestantProject.create(contestant_id: gretchen.id, project_id: upholstery_tux.id)
      ContestantProject.create(contestant_id: erin.id, project_id: boardfit.id)
      visit '/contestants'
        save_and_open_page

      within "#contestant_#{jay.id}" do
        expect(page).to have_content("Jay McCarroll")
        expect(page).to have_content("News Chic")
        expect(page).to_not have_content("Gretchen Jones")
        expect(page).to_not have_content("Boardfit")
      end

      within "#contestant_#{gretchen.id}" do
        expect(page).to have_content("Gretchen Jones")
        expect(page).to have_content("News Chic")
        expect(page).to have_content("News Chic")
        expect(page).to_not have_content("Boardfit")
      end

      within "#contestant_#{erin.id}" do
        expect(page).to have_content("Erin Robertson")
        expect(page).to have_content("Boardfit")
        expect(page).to_not have_content("News Chic")
      end
    end
  end
end