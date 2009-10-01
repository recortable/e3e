require File.expand_path(File.dirname(__FILE__) + '/authentication_methods.rb')

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  layout 'e3e'

  filter_parameter_logging :password
  helper_method :qt
  helper_method :current_user, :signed_in?
  helper_method :current_admin, :admin?

  include AuthenticationMethods

  private
  def qt(*symbols)
    last = symbols.pop
    I18n.t(last, :scope => symbols)
  end
end
