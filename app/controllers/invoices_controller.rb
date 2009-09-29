class InvoicesController  < ApplicationController

  def show
    if current_admin && params[:user_id]
    elsif current_user
      @invoice = current_user.invoice(service)
      respond_to do |format|
        format.html { render :action => 'edit'}
        format.xml { render :xml => @invoices}
      end
    else
      require_user
    end
  end

  def update
    require_user
    flash[:notice] = t(:updated)

    params[:consumption].each do |param|
      if !param[0].blank?
        Consumption.find(param[0]).update_attributes(param[1])
      else
        param[:user_id] = current_user.id
        param[:service] = service
        Consumption.create(param)
      end
    end

    redirect_to next_step
  end

end
