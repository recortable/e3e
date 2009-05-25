
class Invoice
  GAS = 'gas'
  ELEC = 'elec'

  attr_accessor :service

  def initialize(service, user)
    @type = type
    @service = service
  end

  def chart
    size = "350x200"
    type = 'bvs'
    data = 't:10,50,60,80,40,20,15,35,60'
    color = '4D89F9'
    "http://chart.apis.google.com/chart?chs=#{size}&cht=#{type}&chd=#{data}&chco=#{color}"
  end
end