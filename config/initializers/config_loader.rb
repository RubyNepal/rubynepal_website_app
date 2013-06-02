if Rails.env.production?
    APP_CONFIG = {}
    APP_CONFIG[:http_username] = ENV['http_username']
    APP_CONFIG[:http_password] = ENV['http_password']
    APP_CONFIG.symbolize_keys!
else
    APP_CONFIG =  YAML.load_file("#{Rails.root}/config/app_config.yml")[Rails.env].symbolize_keys
end