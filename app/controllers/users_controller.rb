class UsersController < ApplicationController

  before_filter :require_admin, :only => [:index]

  def index
    @users = User.all
    render :layout => 'admin'
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = t(:created)
      redirect_to survey_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = current_user
    @user.password = ''
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = t(:updated)
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end
end
