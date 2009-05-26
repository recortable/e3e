
class ElectricidadController < InvoicesController

  def service
    Invoice::ELEC
  end

  def bar_color
    "#1F767F"
  end

end