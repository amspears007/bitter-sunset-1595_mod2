class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    # require 'pry'; binding.pry
    @number_of_contestants= @project.number_of_contestants
  end
end