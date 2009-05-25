
class Consumption

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