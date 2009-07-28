
RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem "authlogic"

  config.time_zone = 'UTC'
  config.i18n.default_locale = :es

  config.action_controller.resources_path_names = { :new => 'nueva', :edit => 'cambia' }

end

require "form_helper_answer_extensions"

ActionView::Base.field_error_proc = Proc.new { |html_tag, instance| "<span class='fieldWithErrors'>#{html_tag}</span>" }
