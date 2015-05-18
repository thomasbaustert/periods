require 'periods/date_calculator'
require 'periods/modules/yearly_period'

module Periods
  module Modules
    module Year

      def self.included(base)
        base.class_eval do
          include Periods::Modules::YearlyPeriod
          include InstanceMethods
        end
      end

      module InstanceMethods
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

        def months
          months = [Periods::Month.for(start_date)]
          1.upto(11) do |idx|
            months << Periods::Month.for(start_date.next_month(idx))
          end
          months
        end

        def quarters
          quarters = [Periods::Quarter.for(start_date)]
          1.upto(3) do |idx|
            quarters << Periods::Quarter.for(start_date.next_month(idx*3))
          end
          quarters
        end

        private
          def init_with_date(date)
            init_with_dates(
                beginning_of_month(date), end_of_month(beginning_of_month(date).next_year.prev_day))
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
