class TicketsController < ApplicationController
  def show
    @project = Project.find(params[:project_id]) 
    @ticket  = Ticket.find(params[:id], :params => { :project_id => params[:project_id] })
    
    @params  = @ticket.params
    # raise @params.inspect
    respond_to do |wants|
      # wants.html
      
      wants.json do
        render :json => @ticket.params
      end
    end
  end
end