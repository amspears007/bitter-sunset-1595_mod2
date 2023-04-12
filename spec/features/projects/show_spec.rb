require 'rails_helper'

RSpec.describe 'Project Show', type: :feature do
  let!(:recycled_material_challenge) {Challenge.create(theme: "Recycled Material", project_budget: 1000)}
  let!(:news_chic) {recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")}
  let!(:boardfit) {recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")}

  let!(:jay) {Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)}
  let!(:gretchen) {Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)}

  let!(:jay_news_chic) {ContestantProject.create!(contestant_id: jay.id, project_id: news_chic.id)}
  let!(:gretchen_news_chic) {ContestantProject.create!(contestant_id: gretchen.id, project_id: news_chic.id)}
  let!(:gretchen_boardfit) {ContestantProject.create!(contestant_id: gretchen.id, project_id: boardfit.id)}

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
    it 'I see a count of the number of contestants on this project' do
      visit "/projects/#{news_chic.id}"

      expect(news_chic.number_of_contestants).to eq(2)
      expect(page).to have_content("Number of Contestants: 2")
    end
  end
end