class ProjectsController < ApplicationController

  def show
    @project = Project.load(params[:id])
    @memberships = Project.memberships(params[:id])
  end

end
