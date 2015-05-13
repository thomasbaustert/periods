module Periods
  module QuarterlyPeriod

    def self.included(base)
      base.class_eval do
        include Periods::Period
        include InstanceMethods
        extend ClassMethods
      end
    end

    module ClassMethods
      ##
      # '25.06.2015' => 25.06.2015 - '24.07.2015'
      #
      def for(date)
        date = Date.parse(date.to_s)
        new(date, date.next_month(3).prev_day)
      end
    end

    module InstanceMethods
      ##
      # 25.06.2015 => 25.07.2015
      #
      def next
        self.class.for(start_date.next_month(3))
      end

      ##
      # 25.06.2015 => 25.05.2015
      #
      def previous
        self.class.for(start_date.prev_month(3))
      end

    end
  end
end