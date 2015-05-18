require 'periods/date_calculator'
require 'periods/modules/period'

module Periods
  module Modules
    module QuarterlyPeriod

      def self.included(base)
        base.class_eval do
          include Periods::Modules::Period
          include InstanceMethods
          extend ClassMethods
        end
      end

      module ClassMethods
        ##
        # '25.06.2015' => 25.06.2015 - '24.07.2015'
        #
        def for(date)
          new(date)
        end
      end

      module InstanceMethods

        def initialize(date)
          if date.is_a?(QuarterlyPeriod)
            super(date.start_date, date.end_date)
          elsif date.is_a?(Date)
            super(date, date.next_month(3).prev_day)
          elsif date.is_a?(String)
            date = Date.parse(date.to_s)
            super(date, date.next_month(3).prev_day)
          else
            raise ArgumentError, "#{self.class} cannot be initialized with #{date.class}"
          end
        end

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

      end
    end
  end
end

