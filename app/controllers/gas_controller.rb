
class GasController < InvoicesController
  def service
    Invoice::GAS
  end

  def next_step
    gas_path
  end
end