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
    end
  end
end
