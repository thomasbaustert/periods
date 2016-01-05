require 'periods/modules/period'
require 'periods/modules/single_date_initialize'

module Periods
  module Modules
    module YearlyPeriod

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
        # 25.06.2015 => 25.06.2016
        #
        def next
          self.class.for(start_date.next_year)
        end

        ##
        # 25.06.2015 => 25.06.2014
        #
        def previous
          self.class.for(start_date.prev_year)
        end

        def days
          (self.next.start_date - start_date).to_i
        end

        private
          def init_with_date(date)
            init_with_dates(date, date.next_year.prev_day)
          end

      end
    end
  end
end
