require 'rails_helper'


RSpec.describe Project, type: :model do
  let!(:recycled_material_challenge) {Challenge.create(theme: "Recycled Material", project_budget: 1000)}
  let!(:news_chic) {recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")}
  let!(:boardfit) {recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")}

  let!(:jay) {Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)}
  let!(:gretchen) {Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)}
  
  let!(:jay_news_chic) {ContestantProject.create!(contestant_id: jay.id, project_id: news_chic.id)}
  let!(:gretchen_news_chic) {ContestantProject.create!(contestant_id: gretchen.id, project_id: news_chic.id)}
  let!(:gretchen_boardfit) {ContestantProject.create!(contestant_id: gretchen.id, project_id: boardfit.id)}

  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :material}
  end

  describe "relationships" do
    it {should belong_to :challenge}
    it {should have_many :contestant_projects}
    it {should have_many(:contestants).through(:contestant_projects)}
  end

    it 'counts the number of contestants in a project' do
    
      expect(news_chic.number_of_contestants).to eq(2)
      expect(boardfit.number_of_contestants).to eq(1)
  end
end
