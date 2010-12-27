class Project < Lighthouse::Project
  def restore_defaults(id)
    project = self
    project.public = false
    project.closed_states = 
"complete/CCCCCC    # work complete, ticket closed
hold/EEBB00        # work on hold
invalid/CCCC00     # invalid ticket, abandoned
duplicate/CC66FF   # duplicate, should be linked to other tic"
    project.open_states = 
"new/FF1177                 # default, needs dev triage
discovery/0099FF           # assigned to pm for more info
ready_for_dev/66AA00       # assigned to dev and waiting for start
in_progress/3366FF         # work has begun
dev_complete/C2FF0B        # work complete but not ready to test
qa_ready/660000            # ready for qa, assigned to pm"
    project.save
  end
    
  def add_default_bins(id)
    bin_params = [
      { :name => "My Open Tickets",   :query => "responsible:me state:open",      :default => true },
      { :name => "New",               :query => "state:new",                      :default => false },
      { :name => "Discovery",         :query => "state:discovery",                :default => false },
      { :name => "Ready For Dev",     :query => "state:ready_for_dev",            :default => false },
      { :name => "In Progress",       :query => "state:in_progress",              :default => false },
      { :name => "Dev Complete",      :query => "state:dev_complete",             :default => false },
      { :name => "QA Ready",          :query => "state:qa_ready",                 :default => false },
      { :name => "Complete",          :query => "state:complete",                 :default => false },
      { :name => "Hold",              :query => "state:hold",                     :default => false },
      { :name => "Invalid/Duplicate", :query => "state:invalid state:duplicate",  :default => false }
    ]
    bin_params.each do |params|
      bin = Lighthouse::Bin.new(:project_id => id )
      bin.name = params[:name]
      bin.query = params[:query]
      bin.default = params[:default]
      bin.shared = true
      bin.save
    end
  end    
  
end
