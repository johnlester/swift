APP_CONSTANTS = YAML.load_file("#{Rails.root}/config/app_constants.yml")[Rails.env]
APP_CONSTANTS.freeze
#consider recursive deep freeze
