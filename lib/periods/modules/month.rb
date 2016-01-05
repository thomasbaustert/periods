require 'periods/date_calculator'
require 'periods/modules/monthly_period'

module Periods
  module Modules
    module Month

      def self.included(base)
        base.class_eval do
          include Periods::Modules::MonthlyPeriod
          include InstanceMethods
          alias_method :succ, :next
        end
      end

      module InstanceMethods

        def month
          start_date.month
        end

        alias_method :number, :month

        def year
          start_date.year
        end

        def to_s(*args)
          if args.first.to_s == 'month'
            "#{start_date.strftime("%m.%Y")}"
          else
            super
          end
        end

        private

          def init_with_date(date)
            init_with_dates(beginning_of_month(date), end_of_month(date))
          end

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
