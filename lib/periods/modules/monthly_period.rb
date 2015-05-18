require 'periods/modules/period'

module Periods
  module Modules
    module MonthlyPeriod

      def self.included(base)
        base.class_eval do
          include Periods::Modules::Period
          include InstanceMethods
          extend ClassMethods
        end
      end

      module ClassMethods
        def for(date)
          new(date)
        end
      end

      module InstanceMethods
        ##
        # Initialize a new monthly period based on given date.
        #
        # @example
        #
        #    period = MonthlyPeriod.new(Date.new(2015,6,25))
        #    period = MonthlyPeriod.new('25.06.2015')
        #    period = MonthlyPeriod.new(MonthlyPeriod.for('25.06.2015')
        #
        def initialize(date)
          if date.is_a?(MonthlyPeriod)
            super(date.start_date, date.end_date)
          elsif date.is_a?(Date)
            super(date, date.next_month.prev_day)
          elsif date.is_a?(String)
            date = Date.parse(date.to_s)
            super(date, date.next_month.prev_day)
          else
            raise ArgumentError, "#{self.class} cannot be initialized with #{date.class}"
          end
        end

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

      end
    end
  end
end
