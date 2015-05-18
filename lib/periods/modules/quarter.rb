require 'periods/date_calculator'
require 'periods/modules/quarterly_period'
require 'periods/month'

module Periods
  module Modules
    module Quarter

      def self.included(base)
        base.class_eval do
          include Periods::Modules::QuarterlyPeriod
          include InstanceMethods
        end
      end

      module InstanceMethods

        def months
          [ Periods::Month.for(start_date),
            Periods::Month.for(start_date.next_month),
            Periods::Month.for(start_date.next_month(2)) ]
        end

        private
          def init_with_date(date)
            init_with_dates(beginning_of_month(date), end_of_month(date.next_month(2)))
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
