require 'periods/modules/period'

module Periods
  module Modules
    module YearlyPeriod

      def self.included(base)
        base.class_eval do
          include Periods::Modules::Period
          include InstanceMethods
          extend ClassMethods
        end
      end

      module ClassMethods
        ##
        # '25.06.2015' => 25.06.2015 - '24.06.2016'
        #
        def for(date)
          date = Date.parse(date.to_s)
          new(date, date.next_year.prev_day)
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

        def include?(period)
          if period.is_a?(String) || period.is_a?(Date)
            super
          elsif period.is_a?(Period)
            start_date <= period.start_date && period.end_date <= end_date
          else
            false
          end
        end

      end
    end
  end
end