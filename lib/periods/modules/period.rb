module Periods
  module Modules
    module Period

      def self.included(base)
        base.class_eval do
          include Comparable
          include InstanceMethods
        end
      end

      module InstanceMethods
        attr_reader :start_date, :end_date

        def initialize(start_date, end_date)
          @start_date = Date.parse(start_date.to_s)
          @end_date = Date.parse(end_date.to_s)
        end

        def ==(period)
          start_date == period.start_date && end_date == period.end_date
        end

        def <=>(period)
          if start_date > period.start_date
            1
          elsif start_date < period.start_date
            -1
          else
            0
          end
        end

        def next
          self.class.new(start_date + days, end_date + days)
        end

        def previous
          self.class.new(start_date - days, end_date - days)
        end

        def days
          end_date.yday - start_date.yday + 1
        end

        def include?(period)
          if period.is_a?(Date)
            start_date <= period && period <= end_date
          elsif period.is_a?(String)
            date = Date.parse(period.to_s)
            start_date <= date && date <= end_date
          elsif period.is_a?(Period)
            start_date <= period.start_date && period.end_date <= end_date
          else
            false
          end
        end

        def to_s
          "#{start_date.strftime("%d.%m.%Y")} - #{end_date.strftime("%d.%m.%Y")}"
        end

      end
    end
  end
end
