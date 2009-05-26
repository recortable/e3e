class InvoicesController  < ApplicationController
  before_filter :require_user

  def show
    @invoices = [current_user.invoice(Invoice::GAS), current_user.invoice(Invoice::ELEC)]
    
    respond_to do |format|
      format.html 
      format.xml { render :xml => @invoices}
    end
  end

  def edit
    @invoice = current_user.invoice(params[:service])
  end

  def update
    flash[:notice] = t(:updated)

    params[:consumption].each do |param|
      Consumption.find(param[0]).update_attributes(param[1])
    end

    redirect_to :back
  end

end
