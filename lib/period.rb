##
# A period is defined by a start and an end date.
#
class Period
  include Comparable

  # TODO/05.03.15/02:21/tb support Time?
  attr_reader :start_date, :end_date

  def initialize(start_date, end_date)
    @start_date = Date.parse(start_date.to_s)
    @end_date   = Date.parse(end_date.to_s)
  end

  def ==(period)
    start_date == period.start_date && end_date == period.end_date
  end

  def <=>(period)
    if start_date > period.start_date
      1
    elsif start_date < period.start_date
      -1
    else
      0
    end
  end

  def days
    end_date.yday - start_date.yday + 1
  end

  def include?(date)
    date = Date.parse(date.to_s)
    start_date <= date && date <= end_date
  end

  def to_s
    "#{start_date.strftime("%d.%m.%Y")} - #{end_date.strftime("%d.%m.%Y")}"
  end

  private

    def beginning_of_month(date)
      date.beginning_of_month.to_date
    end

    def end_of_month(date)
      date.end_of_month.to_date
    end
end

