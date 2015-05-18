require 'periods/halfyearly_period'

module Periods
  module Modules
    module Halfyear

      def self.included(base)
        base.class_eval do
          include Periods::Modules::HalfyearlyPeriod
          include InstanceMethods
        end
      end

      module InstanceMethods

        def months
          months = [Periods::Month.for(start_date)]
          1.upto(5) do |idx|
            months << Periods::Month.for(start_date.next_month(idx))
          end
          months
        end

        private
          def init_with_date(date)
            init_with_dates(
                beginning_of_month(date), end_of_month(beginning_of_month(date).next_month(6).prev_day))
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
