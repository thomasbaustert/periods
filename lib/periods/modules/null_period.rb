module Periods
  module Modules
    module NullPeriod

      def self.included(base)
        base.class_eval do
          include Comparable
          include InstanceMethods
        end
      end

      module InstanceMethods

        attr_reader :start_date
        attr_reader :end_date

        def initialize(*args)
        end

        def ==(period)
          self.class == period.class
        end

        def <=>(period)
          0
        end

        def next
          self
        end

        def previous
          self
        end

        def days
          0
        end

        def start_year
          0
        end

        def end_year
          0
        end

        def include?(period)
          false
        end

        def to_s
          "#{self.class.name}"
        end

      end
    end
  end
end
