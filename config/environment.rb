
RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem "authlogic"

  config.time_zone = 'UTC'
  config.i18n.default_locale = :es
end

require "form_helper_answer_extensions"
