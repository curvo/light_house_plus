class Membership < Application
  
  private
  
  def self.valid_methods
    ["all","load"]
  end
end
