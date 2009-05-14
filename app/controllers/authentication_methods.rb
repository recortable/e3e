
module AuthenticationMethods
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  private
  def current_user_session
    return @current_user_session if defined?@current_user_session
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def signed_in?
    !current_user.nil?
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = qt(:flash, :require_user)
      redirect_to new_user_sessions_url
      return false
    end
  end

  def current_admin_session
    return @current_admin_session if defined?@current_admin_session
    @current_admin_session = AdminSession.find
  end

  def current_admin
    return @current_admin if defined?(@current_admin)
    @current_admin = current_admin_session && current_admin_session.record
  end

  def admin?
    !current_admin.nil?
  end

  def require_admin
    unless current_admin
      store_location
      flash[:notice] = qt(:flash, :require_admin)
      redirect_to root_path
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

end