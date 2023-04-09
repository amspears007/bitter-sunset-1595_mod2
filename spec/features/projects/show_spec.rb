require 'rails_helper'

RSpec.describe 'Project Show', type: :feature do
  recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
  news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
  boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

  
  describe 'User Story 1: As a visitor, when I visit ("/projects/:id")' do
    it "I see I see the project's name and material and theme of the challenge that this project belongs to." do
      visit "/projects/#{news_chic.id}"
      save_and_open_page

      expect(page).to have_content("Name: News Chic")
      expect(page).to have_content("Material: Newspaper")
      expect(page).to have_content("Challenge: Recycled Material")
      expect(page).to_not have_content("Name: Boardfit")
    end
  end

  describe "User Story 3 When I visit a project's show page", type: :feature do
   
  end
end