
class ElectricidadController < InvoicesController

  def service
    Invoice::ELEC
  end

  def bar_color
    "#1F767F"
  end

  def next_step
    report_path
  end

end