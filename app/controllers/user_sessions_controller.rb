class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
    @user = User.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = t(:notice)
      redirect_to survey_path
    else
      @user = User.new
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find(params[:id])
    @user_session.destroy
    flash[:notice] = t(:notice)
    redirect_to root_url
  end
end
