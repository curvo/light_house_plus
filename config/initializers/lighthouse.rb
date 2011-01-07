yml_file_path = "#{RAILS_ROOT}/config/api_keys.yml"
if File.exists?(yml_file_path)
  api_keys = YAML::load(File.open(yml_file_path))
  Lighthouse.account = api_keys["lighthouse"]["account"]
  Lighthouse.token = api_keys["lighthouse"]["token"]
else 
  Lighthouse.account = ENV["lighthouse_account"]
  Lighthouse.token = ENV["lighthouse_token"]
end

class Lighthouse::Base
  class << self
    def inherited_with_authorization_fix(base)
      inherited_without_authorization_fix(base)
      base.headers['X-LighthouseToken'] = Lighthouse.token
    end
  
    alias_method_chain :inherited, :authorization_fix
  end
end
