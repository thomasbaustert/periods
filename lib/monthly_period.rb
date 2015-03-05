##
# A monthly period is always one from from starting day.
#
class MonthlyPeriod < Period

  ##
  # '25.06.2015' => 25.06.2015 - '24.07.2015'
  #
  def self.for(date)
    date = Date.parse(date.to_s)
    self.new(date, date + 1.month - 1.day)
  end

  ##
  # 25.06.2015 => 25.07.2015
  #
  def next
    self.class.for(start_date + 1.month)
  end

  ##
  # 25.06.2015 => 25.05.2015
  #
  def previous
    self.class.for(start_date - 1.month)
  end

end

