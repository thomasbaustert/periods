require 'periods/yearly_period'

module Periods
  module Year

    def self.included(base)
      base.class_eval do
        include Periods::YearlyPeriod
        include InstanceMethods
        extend ClassMethods
      end
    end

    module ClassMethods
      ##
      # '25.06.2015' => 01.06.2015 - '30.05.2016'
      #
      def for(date)
        new(date)
      end
    end

    module InstanceMethods

      def initialize(date)
        date = Date.parse(date.to_s)
        super(beginning_of_month(date), end_of_month(beginning_of_month(date).next_year.prev_day))
      end

      ##
      # 01.06.2015 => 01.06.2016
      #
      def next
        self.class.for(start_date.next_year)
      end

      ##
      # 01.06.2015 => 01.06.2014
      #
      def previous
        self.class.for(start_date.prev_year)
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

      def year
        start_date.year
      end

      class YearMonth
        include Periods::Month
      end

      # TODO/13.05.15/05:03/tb ok to return YearMonth and not Month?
      # Same interface but other class. Should be ok for OO.
      def months
        months = [YearMonth.for(start_date)]
        1.upto(11) do |idx|
          months << YearMonth.for(start_date.next_month(idx))
        end
        months
      end

      private

        def beginning_of_month(date)
          Periods::DateCalculator.new(date).beginning_of_month
        end

        def end_of_month(date)
          Periods::DateCalculator.new(date).end_of_month
        end

    end
  end
end