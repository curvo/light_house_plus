class Ticket < Lighthouse::Ticket
  # include Authorization
  # api_keys = YAML::load(File.open("#{RAILS_ROOT}/config/api_keys.yml"))
  # Lighthouse.account = api_keys["lighthouse"]["account"]
  # Lighthouse.token = api_keys["lighthouse"]["token"]
  
    # Lighthouse::Ticket.find(:all, :params => { :project_id => project_id, :q => term })
    # Lighthouse::Ticket.find(ticket_id, :params => { :project_id => project_id })
  
  def params
    project_id = self.project_id? ? self.project_id : self.prefix_options[:project_id]
    
    if self.versions?
      @full_ticket = self
    else
      @full_ticket  = Ticket.find(self.id, :params => { :project_id => project_id })
    end
    versions = @full_ticket.versions
    params = {}
    versions.each do |version|
      version.body_html.to_s.scan(/\{(\S*)\s*:\s*([0-9.]+\s*\w*)\}/) { |parameter, value| 
        value.to_s.scan(/^([0-9.]+)\s*(\w.*?)\s*$/) {|number, unit| 
          if ( unit == "days" || unit == "day" || unit == "d" )
            number = number.to_f * 8
            unit = "hours"
          end
          if ( unit == "minutes" || unit == "minute" || unit == "m" )
            number = number.to_f / 60
            unit = "hours"
          end
          params[parameter] = number.to_f
        }
      }
    end
    params
  end
  
  def stats
    project_id = self.project_id? ? self.project_id : self.prefix_options[:project_id]
    
    if self.versions?
      @full_ticket = self
    else
      @full_ticket  = Ticket.find(self.id, :params => { :project_id => project_id })
    end
    stats = {}
    stats['revisions'] = @full_ticket.versions.length
    # number of attachments and list (who uploaded, link to download)
    # - easy to do
    
    # number of revisions and list (who made changes, summary of what happened (notes, kicked back, whatever))
    # -easy
    
    # related milestones over time
    # fairly easy
    
    # length of time ticket has been open
    # simple

    # status relating to milestone or deadline
    # simple
    
    
    # assessment of what's going on?
    # hard and interesting
    
    # Who's had the ticket the most - percentage breakdown over time
    
    # Who's updates params? and what did they say?
    
    #  What knowledge is hidden in these tickets?
    
    stats['']
    versions.each do |version|
      version.body_html.to_s.scan(/\{(\S*)\s*:\s*([0-9.]+\s*\w*)\}/) { |parameter, value| 
        value.to_s.scan(/^([0-9.]+)\s*(\w.*?)\s*$/) {|number, unit| 
          if ( unit == "days" || unit == "day" || unit == "d" )
            number = number.to_f * 8
            unit = "hours"
          end
          if ( unit == "minutes" || unit == "minute" || unit == "m" )
            number = number.to_f / 60
            unit = "hours"
          end
          params[parameter] = number.to_f
        }
      }
    end
    params
  end
  
end