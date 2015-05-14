require 'periods/date_calculator'
require 'periods/modules/monthly_period'

module Periods
  module Modules
    module Month

      def self.included(base)
        base.class_eval do
          include Periods::Modules::MonthlyPeriod
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

        alias_method :number, :month

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
end
