##
# A month always starting at first day and ending at last day.
#
class Month < MonthlyPeriod

  def self.for(date)
    self.new(date)
  end

  def initialize(date)
    date = Date.parse(date.to_s)
    @start_date = beginning_of_month(date)
    @end_date   = end_of_month(date)
  end

  def month
    start_date.month
  end

  def year
    start_date.year
  end

  def to_s(*args)
    if args.first.to_s == 'date'
      "#{start_date.strftime("%m.%Y")} (#{start_date.strftime("%d.%m.%Y")} - #{end_date.strftime("%d.%m.%Y")})"
    else
      "#{start_date.strftime("%m.%Y")}"
    end
  end

end

