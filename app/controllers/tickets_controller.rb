class TicketsController < ApplicationController
  def show
    project_id = params[:project_id]
    @project = Project.load(project_id)
    @ticket = Ticket.load(params[:project_id],params[:id])  
    @ticket_versions = @ticket.versions
    @vars = {}
    @ticket_versions.each do |version|
      version.body_html.to_s.scan(/\{(\S*)\s*:\s*(.*)\}/) { |parameter, value| 
        minutes = ""
        warn = "warn message.. "
        warn = warn + " original value:[" + value.to_s + "]"
        value.to_s.scan(/^([0-9.]+)\s*(\w.*?)\s*$/) {|number, unit| 
          warn = warn + " number:[" + number + "] unit:[" + unit + "]"
          if ( unit == "days" || unit == "day" || unit == "d" )
            number = number.to_f * 8 * 60
            unit = "minutes"
          end
          if ( unit == "hours" || unit == "hour" || unit == "h" )
            number = number.to_f * 60
            unit = "minutes"
          end
          if number.to_i > 0 
            minutes = number.to_s
          end
          warn = warn + " minutes:[" + minutes + "]"          
        }
        # raise warn.inspect
        if minutes.to_i > 0 
          @vars[parameter] = minutes
        end
          
          
      }
    end
  end
end