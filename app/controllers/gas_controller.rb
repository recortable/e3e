
class GasController < InvoicesController
  def service
    Invoice::GAS
  end

  def bar_color
    "#DF9A37"
  end

  def next_step
    gas_path
  end
end