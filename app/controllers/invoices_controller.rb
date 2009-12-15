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
      id = param[0]
      if !id.blank?
        attrs = param[1]
        attrs.delete("id");
        Consumption.find(id).update_attributes(param[1])
      else
        param[:user_id] = current_user.id
        param[:service] = service
        Consumption.create(param)
      end
    end
    current_user.update_attribute(:invoice_scale_max, params[:scale_max_value])

    redirect_to params[:next_url].empty? ? {:action => 'show'} : params[:next_url]
  end

end
