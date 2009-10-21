class AboutController < ApplicationController

  CACHED = [:welcome] #, :who, :mission]

  CACHED.each {|action| caches_page action}
    
  def index
    if current_user
      redirect_to survey_path
    else
      redirect_to what_path
    end
  end

  def feedback
    config = APP_CONFIG['mail']
    unless params[:body].blank?
      Pony.mail(:to => config['to'],
          :subject => "e3e feedback - #{Time.now.fecha}",
          :body => params[:body],
          :via => :smtp, :smtp => {
          :host     => 'smtp.gmail.com',
          :port     => '587',
          :user     => config['user'],
          :password => config['password'],
          :auth     => :plain,           
          :domain   => "e3e.calclab.com"   
        })
      flash[:notice] = t(:received)
      redirect_to root_path
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
