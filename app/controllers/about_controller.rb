class AboutController < ApplicationController

  def index
    if current_user
      redirect_to survey_path
    else
      redirect_to what_path
    end
  end

  def development
    render :layout => 'admin'
  end
  
  def statistics
    render :layout => 'admin'
  end

  def development
    require_admin
  end
end
