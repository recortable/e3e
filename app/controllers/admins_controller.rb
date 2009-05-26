class AdminsController < ApplicationController
  before_filter :require_admin

  def index
    redirect_to users_path
  end

  def show
    redirect_to users_path
  end
end
