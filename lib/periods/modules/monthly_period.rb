require 'periods/modules/period'
require 'periods/modules/single_date_initialize'

module Periods
  module Modules
    module MonthlyPeriod

      def self.included(base)
        base.class_eval do
          include Periods::Modules::Period
          include SingleDateInitialize
          include InstanceMethods
        end
      end

      module InstanceMethods
        ##
        # 25.06.2015 => 25.07.2015
        #
        def next
          self.class.for(start_date.next_month)
        end

        ##
        # 25.06.2015 => 25.05.2015
        #
        def previous
          self.class.for(start_date.prev_month)
        end

        private
          def init_with_date(date)
            init_with_dates(date, date.next_month.prev_day)
          end

      end
    end
  end
end
