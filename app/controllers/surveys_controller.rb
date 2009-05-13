class SurveysController < ApplicationController
  before_filter :require_user
  
  def show
    respond_to do |format|
      format.html { redirect_to :action => 'edit' }
      format.xml { }
    end
  end
  
  def edit
    @survey = @current_user.survey
  end
  
  def update
    @survey = @current_user.survey
    if @survey.update_attributes(params[:survey])
      flash[:notice] = "Successfully updated survey."
      redirect_to @survey
    else
      render :action => 'edit'
    end
  end
end
