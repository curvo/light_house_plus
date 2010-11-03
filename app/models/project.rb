class Project
 
  def self.all
    cache_name = self.name.downcase + "_all"
    this_class = Lighthouse.resources.select {|method| method.name.to_s =="Lighthouse::#{self.name}" }.first
    all = Rails.cache.fetch(cache_name) do
              this_class.find(:all)
          end
  end

  def self.load(id)
    all = self.all()
    this = []
    all.each do |project|
      if id == project.id.to_s
        this = project
      end
    end
    this
  end
  
  def self.restore_defaults(id)
    project = self.load(id)
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
    
  def self.add_default_bins(id)
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
   
  def self.memberships(id)
    #get memberships
    all = Rails.cache.read('project_' + id + '_memberships')
    all_users = User.all
    all_users_plus = []
    # need to make copy of all_users to get unfrozen array (caching issue)
    all_users_plus.replace(all_users) 
    if all.to_s == ""
      project = self.load(id)
      all = project.memberships
      Rails.cache.write('project_' + id + '_memberships', all)
    end   
    # parse and add new users
    all.each do |membership|
      if all_users_plus.index(membership.user).to_s.empty?
        all_users_plus << membership.user
      end
    end
    # store cache
    unless all_users == all_users_plus
      Rails.cache.write('users_all', all_users_plus)
    end  
    all
  end
end
