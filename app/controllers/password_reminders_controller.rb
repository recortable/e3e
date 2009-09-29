class PasswordRemindersController < ApplicationController
  def show
    @password_reminder = PasswordReminder.new
  end

  def new
    @password_reminder = PasswordReminder.find(params[:password_reminder])
    if @password_reminder.user.nil?
      flash[:notice] = t(:fail)
      redirect_to :action => 'show'
    end
  end

  def create
    @password_reminder = PasswordReminder.find(params[:password_reminder])
    if @password_reminder.user.nil?
      flash[:notice] = t(:fail)
      render :action => 'new'
    elsif !@password_reminder.valid?
      flash[:notice] = t(:fail)
      redirect_to :action => 'show'
    else
      flash[:notice] = t(:created)
      user = @password_reminder.user
      UserSession.create(user)
      redirect_to edit_user_path(user)
    end
  end
end
