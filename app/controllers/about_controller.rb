class AboutController < ApplicationController

  def development
    render :layout => 'admin'
  end
  
  def statistics
    render :layout => 'admin'
  end
end
