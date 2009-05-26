class SurveysController < ApplicationController
  
  def show
    if admin? && params[:user_id]
      @user = User.find(params[:user_id])
      @survey = @user.survey
      respond_to do |format|
        format.html { render :action => 'show' }
        format.xml { render :xml => @survey }
      end
    elsif current_user
      @survey = @current_user.survey
      load_municipios_provincias
      respond_to do |format|
        format.html { render :action => 'edit' }
        format.xml { render :xml => @survey }
      end
    else
      require_user
    end
  end
  

  
  def update
    require_user
    @survey = @current_user.survey
    if @survey.update_attributes(params[:survey])
      flash[:notice] = t(:flash)
      redirect_to survey_path
    else
      load_municipios_provincias
      render :action => 'edit'
    end
  end

  private
  def load_municipios_provincias
    @provincias_select = Provincia.all.collect {|p| [ p.name, p.id ] }
    if @survey.provincia
      @municipios_select = @survey.provincia.municipios.collect {|m| [m.name, m.id] }
    else
      @municipios_select = []
    end
  end
end
