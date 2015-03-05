module Periods
  module Month

    def self.included(base)
      base.class_eval do
        include Periods::Period
        include Periods::MonthlyPeriod
        include InstanceMethods
        extend ClassMethods
      end
    end

    module ClassMethods
      def for(date)
        new(date)
      end
    end

    module InstanceMethods

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
  end
end