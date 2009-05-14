class SurveysController < ApplicationController
  before_filter :require_user
  
  def show
    respond_to do |format|
      format.html { redirect_to :action => 'edit' }
      format.xml { render :xml => @current_user.survey }
    end
  end
  
  def edit
    @survey = @current_user.survey
    @provincias_select = Provincia.all.collect {|p| [ p.name, p.id ] }
    if @survey.provincia
      @municipios_select = @survey.provincia.municipios.collect {|m| [m.name, m.id] }
    else
      @municipios_select = []
    end
  end
  
  def update
    @survey = @current_user.survey
    if @survey.update_attributes(params[:survey])
      flash[:notice] = qt(:flash, :survey, :updated)
      redirect_to edit_survey_path
    else
      render :action => 'edit'
    end
  end
end
