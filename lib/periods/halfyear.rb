require 'periods/halfyearly_period'

module Periods
  module Halfyear

    def self.included(base)
      base.class_eval do
        include Periods::HalfyearlyPeriod
        include InstanceMethods
        extend ClassMethods
      end
    end

    module ClassMethods
      ##
      # '25.06.2015' => 01.06.2015 - '30.11.2015'
      #
      def for(date)
        new(date)
      end
    end

    module InstanceMethods

      def initialize(date)
        date = Date.parse(date.to_s)
        super(beginning_of_month(date), end_of_month(beginning_of_month(date).next_month(6).prev_day))
      end

      class HalfyearMonth
        include Periods::Month
      end

      # TODO/13.05.15/05:03/tb ok to return HalfyearMonth and not Month?
      # Same interface but other class. Should be ok for OO.
      def months
        months = [HalfyearMonth.for(start_date)]
        1.upto(5) do |idx|
          months << HalfyearMonth.for(start_date.next_month(idx))
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