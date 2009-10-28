
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem "authlogic"
  config.gem "newrelic_rpm"

  config.time_zone = 'UTC'
  config.i18n.default_locale = :es
  
  config.load_paths += %W( #{RAILS_ROOT}/lib )

  config.action_controller.resources_path_names = { :new => 'nueva', :edit => 'cambia' }
  config.action_controller.page_cache_directory = RAILS_ROOT + "/public/cache/"

end

require "form_helper_answer_extensions"

ActionView::Base.field_error_proc = Proc.new { |html_tag, instance| "<span class='fieldWithErrors'>#{html_tag}</span>" }
