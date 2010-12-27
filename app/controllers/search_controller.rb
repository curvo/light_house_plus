class SearchController < ApplicationController
  def index
    if params[:search]
      @search_term = params[:search][:term].to_s
      @search_project_id= params[:search][:project_id].to_i
      @search_project = Project.find(@search_project_id)      
    end
    @tickets = @search_term ? Ticket.find(:all, :params => { :project_id => @search_project_id, :q => @search_term }) : []
    @full_tickets = []
      
    @projects = Project.find(:all)
  end
end
