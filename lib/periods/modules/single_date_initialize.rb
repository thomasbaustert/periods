module Periods
  module Modules
    module SingleDateInitialize

      def self.included(base)
        base.class_eval do
          extend ClassMethods
          include InstanceMethods
        end
      end

      module ClassMethods
        def for(date)
          new(date)
        end
      end

      module InstanceMethods
        ##
        # Initialize a new period based on a single given date.
        #
        # @example
        #
        #    period = <Class>.new(Date.new(2015,6,25))
        #    period = <Class>.new('25.06.2015')
        #    period = <Class>.new(<Class>.new('25.06.2015')
        #
        def initialize(date)
          if date.is_a?(self.class)
            init_with_dates(date.start_date, date.end_date)
          elsif date.is_a?(Date)
            init_with_date(date)
          elsif date.is_a?(String)
            init_with_date(Date.parse(date.to_s))
          else
            raise ArgumentError, "#{self.class} cannot be initialized with #{date.class}"
          end
        end

        protected
          def init_with_date(date)
            raise "Please implement."
          end

        private
          def init_with_dates(start_date, end_date)
            @start_date = start_date
            @end_date = end_date
          end
      end
    end
  end
end
