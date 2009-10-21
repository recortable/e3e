

require "yaml"

APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/wecex.yml")['wecex']

