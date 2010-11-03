class SearchController < ApplicationController
  def index
    if params[:search]
      @search_term = params[:search][:term].to_s
      @search_project_id= params[:search][:project_id].to_i
    end
    @tickets = @search_term ? Ticket.search(@search_project_id,@search_term) : []
    @projects = Project.all()
  end
end
