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

end
