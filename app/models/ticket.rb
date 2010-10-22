class Ticket
  
  def self.search(project_id,term)
    Lighthouse::Ticket.find(:all, :params => { :project_id => project_id, :q => term })
  end
  
  def self.load(project_id,ticket_id)
    Lighthouse::Ticket.find(ticket_id, :params => { :project_id => project_id })
  end
  
end