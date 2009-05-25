
class Invoice
  GAS = 'gas'
  ELEC = 'elec'

  attr_accessor :service

  def self.gas(user)
    Invoice.new(GAS, user)
  end

  def self.elec(user)
    Invoice.new(ELEC, user)
  end

  def initialize(service, user)
    @user = user
    @service = service
  end

    MESES = %w(Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Diciembre)
  MSS = MESES.map{|m| m[0..2]}

  def months
    0.upto(11).each {|n| yield n}
  end

  def name(month)
    "#{MESES[month]} del 2009"
  end

  def label(month)
    "#{MSS[month]} 09"
  end

  def value(month)
    1300
  end
end