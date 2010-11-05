class TicketsController < ApplicationController
  def show
    project_id = params[:project_id]
    @project = Project.load(project_id)
    @ticket = Ticket.load(params[:project_id],params[:id])  
    @ticket_versions = @ticket.versions
    @vars = {}
    @ticket_versions.each do |version|
      version.body_html.to_s.scan(/\{(\S*)\s*:\s*([0-9.]+\s*\w*)\}/) { |parameter, value| 
        hours = ""
        warn = "warn message.. "
        warn = warn + " original value:[" + value.to_s + "]"
        value.to_s.scan(/^([0-9.]+)\s*(\w.*?)\s*$/) {|number, unit| 
          warn = warn + " number:[" + number + "] unit:[" + unit + "]"
          if ( unit == "days" || unit == "day" || unit == "d" )
            number = number.to_f * 8
            unit = "hours"
          end
          if ( unit == "minutes" || unit == "minute" || unit == "m" )
            number = number.to_f / 60
            unit = "hours"
          end
          hours = number.to_s
          warn = warn + " hours:[" + hours + "]"          
        }
        # raise warn.inspect
        @vars[parameter] = hours
          
          
      }
    end
  end
end