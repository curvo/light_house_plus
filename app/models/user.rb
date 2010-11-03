class User
  
  # refresh not yet implemented
  def self.refresh(id)
    Lighthouse::User.find(id)
  end
  
  def self.load(id)
    Membership.load({:user_id => id}).user
  end
  private
  
  def self.valid_methods
    ["all","load"]
  end
  
end