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
      flash[:notice] = t(:create, :scope => [:controllers, :users])
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = t(:update, :scope => [:controllers, :users])
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end
end
