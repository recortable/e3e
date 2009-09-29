class Consumption < ActiveRecord::Base
  belongs_to :user

  MESES = %w(Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Diciembre)
  MSS = MESES.map{|m| m[0..2]}

  def date

  end

  def name
    "#{MESES[month_index]} del #{year}"
  end

  def label
    "#{MSS[month_index]}#{yr}"
  end

  private
  def month_index
    @month_index ||= period[4..5].to_i - 1
  end

  def year
    period[0..3]
  end

  def yr
    period[2..3]
  end
  
end
