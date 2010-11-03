class Application < ActiveRecord::Base
  self.abstract_class = true
  # custom ActiveRecord methods should go here, and all application models should inherit from
  #   this instead of ActiveRecord::Base
  
  def self.all(params)
    check_method("all")
    cache_name = self.name.downcase + "_all"
    this_class = Lighthouse.resources.select {|method| method.name.to_s =="Lighthouse::#{self.name}" }.first
    all = Rails.cache.fetch(cache_name) do
      # raise params.inspect
            this_class.find(:all, :params => params)
          end
  end
  
  def self.load(params)
    check_method("load")
    # raise params.inspect unless params.empty?
    raise Application.subclasses.first.inspect
    # this_class = Application.methods.select {|method| method.name.to_s =="Lighthouse::#{self.name}" }.first
    # 
    # raise method_name
    all = Application.subclasses.first.all({})
    this = []
    all.each do |object|
      if id == object.user.id.to_s
        this = object.user
      end
    end
    this
  end

  
  private
  
  def self.check_method(method)
    if valid_methods.to_s.length == 0
      raise "please define valid_methods for class: " + self.name
    end
    
    unless valid_methods.index(method)
      raise ("'" + method + "' is not a valid method for " + self.name).inspect
    end
    
    # all good!
  end
end