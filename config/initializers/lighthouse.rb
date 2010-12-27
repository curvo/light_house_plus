api_keys = YAML::load(File.open("#{RAILS_ROOT}/config/api_keys.yml"))
Lighthouse.account = api_keys["lighthouse"]["account"]
Lighthouse.token = api_keys["lighthouse"]["token"]

class Lighthouse::Base
  class << self
    def inherited_with_authorization_fix(base)
      inherited_without_authorization_fix(base)
      base.headers['X-LighthouseToken'] = Lighthouse.token
    end
  
    alias_method_chain :inherited, :authorization_fix
  end
end
