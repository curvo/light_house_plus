class ProjectsController < ApplicationController

  def show
    @project = Project.find(params[:id])
    
    if params[:restore_defaults] == "yes"
      @project.add_default_bins(params[:id])
      @project.restore_defaults(params[:id])
    end
  end

end
