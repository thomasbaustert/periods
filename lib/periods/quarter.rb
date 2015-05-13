require 'periods/date_calculator'

module Periods
  module Quarter

    def self.included(base)
      base.class_eval do
        include Periods::Period
        include Periods::QuarterlyPeriod
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
        @end_date   = end_of_month(@start_date.next_month(2))
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