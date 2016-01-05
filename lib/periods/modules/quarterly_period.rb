require 'periods/date_calculator'
require 'periods/modules/period'
require 'periods/modules/single_date_initialize'

module Periods
  module Modules
    module QuarterlyPeriod

      def self.included(base)
        base.class_eval do
          include Periods::Modules::Period
          include SingleDateInitialize
          include InstanceMethods
          alias_method :succ, :next
        end
      end

      module InstanceMethods
        ##
        # 25.06.2015 => 25.07.2015
        #
        def next
          self.class.for(start_date.next_month(3))
        end

        ##
        # 25.06.2015 => 25.05.2015
        #
        def previous
          self.class.for(start_date.prev_month(3))
        end

        private
          def init_with_date(date)
            init_with_dates(date, date.next_month(3).prev_day)
          end
      end
    end
  end
end

