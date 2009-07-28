class AboutController < ApplicationController

  CACHED = [:what, :who, :mission]

  CACHED.each {|action| caches_page action}
    

    def index
    if current_user
      redirect_to survey_path
    else
      redirect_to what_path
    end
  end

  def clear_cache
    CACHED.each {|action| expire_action action}
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
