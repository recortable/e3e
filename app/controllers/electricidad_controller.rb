
class ElectricidadController < InvoicesController

  def service
    Invoice::ELEC
  end

  def next_step
    report_path
  end

end