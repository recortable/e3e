class AdminSessionsController < ApplicationController
  def new
    @admin_session = AdminSession.new
  end
  
  def create
    @admin_session = AdminSession.new(params[:admin_session])
    if @admin_session.save
      flash[:notice] = t(:create, :scope => [:controllers, :admin_sessions])
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @admin_session = AdminSession.find(params[:id])
    @admin_session.destroy
      flash[:notice] = t(:destroy, :scope => [:controllers, :admin_sessions])
    redirect_to root_url
  end
end
