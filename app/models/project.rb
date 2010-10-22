class Project
 
  def self.all
    all_cache = Rails.cache.read('projects_all')
    if all_cache.to_s == ""
      all = Lighthouse::Project.find(:all)
      all.sort_by {|p| p.name }
      Rails.cache.write('projects_all', all)
    else
      all_cache
    end
  end
  
  def self.load(id)
    all = self.all
    this = []
    all.each do |project|
      if id == project.id.to_s
        this = project
      end
    end
    this
  end
   
  def self.memberships(id)
    #get memberships
    all = Rails.cache.read('project_' + id + '_memberships')
    all_users = User.all
    all_users_plus = []
    all_users_plus.replace(all_users) # need to make copy to get unfrozen array
    if all.to_s == ""
      project = self.load(id)
      all = project.memberships
      Rails.cache.write('project_' + id + '_memberships', all)
    end   
    # parse and cache users
    all.each do |membership|
      if all_users_plus.index(membership.user).to_s.empty?
        all_users_plus << membership.user
      end
    end
    unless all_users == all_users_plus
      Rails.cache.write('users_all', all_users_plus)
    end  
    all
  end
   
end
