class ProjectsController < ApplicationController

  def show
    if params[:restore_defaults] == "yes"
      Project.add_default_bins(params[:id])
      Project.restore_defaults(params[:id])
    end
    @project = Lighthouse::Project.find(params[:id])
    @memberships = @project.memberships
    @bins = @project.bins
    # ProjectMembership.all({ :project_id => params[:id] })
  end

end
