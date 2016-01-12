require 'periods/modules/period'
require 'periods/modules/single_date_initialize'

module Periods
  module Modules
    module WeeklyPeriod

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
        # 25.06.2015 => 02.07.2015
        #
        def next
          self.class.for(start_date + 7)
        end

        ##
        # 02.07.2015 => 25.06.2015
        #
        def previous
          self.class.for(start_date - 7)
        end

        def days
          7
        end

        private
          def init_with_date(date)
            init_with_dates(date, date + 6)
          end

      end
    end
  end
end
