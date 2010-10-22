api_keys = YAML::load(File.open("#{RAILS_ROOT}/config/api_keys.yml"))
Lighthouse.account = api_keys["lighthouse"]["account"]
Lighthouse.token = api_keys["lighthouse"]["token"]