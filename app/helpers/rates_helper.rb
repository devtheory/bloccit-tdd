module RatesHelper
  def rates_to_buttons(rates)
    raw rates.map {|l| link_to l.severity, rate_path(id: l.id), class: 'btn btn-info'}.join(' ')
  end
end
