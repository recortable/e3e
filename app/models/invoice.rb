
class Invoice
  GAS = 'gas'
  ELEC = 'elec'
  MONTHS = 18

  UNITS = {:gas => 'm3', :elec => 'kW/h'}

  attr_accessor :service

  def initialize(service, user)
    @user = user
    @service = service
    @consumptions = @user.consumptions(service)
    initialize_consumptions if @consumptions.size == 0
  end

  def months(&block)
    index = 0
    @consumptions.each do |consumption|
      block.call(consumption, index)
      index += 1
    end
  end

  def units
    UNITS[@service.to_sym]
  end

  private
  def initialize_consumptions
    year_ago = Date.today << MONTHS
    max = MONTHS - 1
    0.upto(max) do |offset|
      date = year_ago >> offset
      @consumptions << Consumption.new(:period => date.strftime("%Y%m"))
    end
  end
end