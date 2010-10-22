class TicketsController < ApplicationController
  def show
    @project = Project.load(params[:project_id])
    @memberships = Project.memberships(params[:project_id])
    @ticket = Ticket.load(params[:project_id],params[:id])  
    @ticket_versions = @ticket.versions
    pass_variables = Regexp.new('.*\{(.*)\}')
    versions_html = []
    these_vars = []
    @ticket_versions.each do |version|
      # raise version.body_html.inspect
      versions_html << version.body_html
      these_vars << [ pass_variables.match(version.body_html) ]
     #  if these_vars.present?
     #   #  raise these_vars.inspect
     #   # raise these_vars[:estimate].inspect
     # end
    end
    raise these_vars.inspect
    
    # project = Project.load(params[:project_id])
    # @messages = project.messages
    # @milestones = project.milestones # loads any milestones
    # @bins = project.bins # loads any bins 
    # @changesets = project.changesets # loads any revisions on ticket headers or project under a project - note notes/emails
    # @memberships = project.memberships # works and loads users records with membership to project    
    # @tags = project.tags # loads tag for all tickets across project
    
    
  end
end