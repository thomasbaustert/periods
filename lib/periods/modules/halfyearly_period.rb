require 'periods/modules/period'
require 'periods/modules/single_date_initialize'

module Periods
  module Modules
    module HalfyearlyPeriod

      def self.included(base)
        base.class_eval do
          include Periods::Modules::Period
          include SingleDateInitialize
          include InstanceMethods
          alias_method :succ, :next
        end
      end

      module InstanceMethods
        def next
          self.class.for(start_date.next_month(6))
        end

        def previous
          self.class.for(start_date.prev_month(6))
        end

        def days
          (self.next.start_date - start_date).to_i
        end

        private
          def init_with_date(date)
            init_with_dates(date, date.next_month(6).prev_day)
          end

      end
    end
  end
end

