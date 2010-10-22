class User

  def self.all
    all_cache = Rails.cache.read('users_all')
    if all_cache.to_s == ""
      []
    else
      all_cache
    end
  end
  
end