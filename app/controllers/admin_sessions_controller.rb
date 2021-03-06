class AdminSessionsController < ApplicationController
  layout 'admin'

  def index
    path = admin? ? users_path : admin_login_path
    redirect_to path
  end

  def new
    @admin_session = AdminSession.new
  end
  
  def create
    @admin_session = AdminSession.new(params[:admin_session])
    if @admin_session.save
      flash[:notice] = t(:flash)
      redirect_to users_path
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @admin_session = AdminSession.find(params[:id])
    @admin_session.destroy
      flash[:notice] = t(:flash)
    redirect_to root_url
  end
end
