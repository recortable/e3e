class UserSurveysController < ApplicationController
  before_filter :require_user

  def show
    @survey = UserSurvey.find(current_user)
    load_municipios_provincias(@survey.provincia_id)
    render :action => 'edit'
  end

  def update
    survey = UserSurvey.find(current_user)
    survey.update(params[:user_survey])
    redirect_to next_or({:action => 'show'})
  end
  
  private
  def load_municipios_provincias(current_provincia = nil)
    @provincias_select = Provincia.all.collect {|p| [ p.name, p.id ] }
    if current_provincia.empty?
      @municipios_select = []
    else
      @municipios_select =current_provincia.municipios.collect {|m| [m.name, m.id] }
    end
  end
end
