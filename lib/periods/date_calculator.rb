module Periods
  class DateCalculator

    def initialize(date)
      @date = to_date(date)
    end

    def beginning_of_month
      _, m, y = split
      to_date("#{1}.#{m}.#{y}")
    end

    def end_of_month
      self.class.new(@date.next_month).beginning_of_month.prev_day
    end

    def split
      @date.strftime('%d.%m.%Y').split('.')
    end

    def to_date(str)
      ::Date.parse(str.to_s)
    end
  end
end