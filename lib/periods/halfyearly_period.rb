module Periods
  module HalfyearlyPeriod

    def self.included(base)
      base.class_eval do
        include Periods::Period
        include InstanceMethods
        extend ClassMethods
      end
    end

    module ClassMethods
      ##
      # '25.06.2015' => 25.06.2015 - '24.12.2015'
      #
      def for(date)
        date = Date.parse(date.to_s)
        new(date, date.next_month(6).prev_day)
      end
    end

    module InstanceMethods
      def next
        self.class.for(start_date.next_month(6))
      end

      def previous
        self.class.for(start_date.prev_month(6))
      end

      def days
        (self.next.start_date - start_date).to_i
      end

      def include?(period)
        if period.is_a?(String) || period.is_a?(Date)
          super
        elsif period.is_a?(Period)
          start_date <= period.start_date && period.end_date <= end_date
        else
          false
        end
      end

    end
  end
end