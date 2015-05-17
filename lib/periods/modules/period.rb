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

        # Returns the start date of this period.
        # @return [Date] the start date of this period.
        attr_reader :start_date

        # Returns the end date of this period.
        # @return [Date] the end date of this period.
        attr_reader :end_date

        ##
        # Initialize a new period with its start and end date.
        #
        # @example
        #
        #    period = Period.new('10.04.2015', '20.05.2015')
        #
        def initialize(start_date, end_date)
          @start_date = Date.parse(start_date.to_s)
          @end_date = Date.parse(end_date.to_s)
        end

        ##
        # Test whether the given period is equal to this one.
        # A period is considered equal if it has the same start and end date.
        #
        # @return [Boolean] true if period is equal, false otherwise.
        #
        # @since 0.0.3
        #
        # @example
        #
        #    period1 = Period.new('10.04.2015', '20.05.2015')
        #    period2 = Period.new('10.04.2015', '20.05.2015')
        #    period3 = Period.new('09.04.2015', '20.05.2015')
        #    period1 == period2 # => true
        #    period1 == period3 # => false
        #
        def ==(period)
          start_date == period.start_date && end_date == period.end_date
        end

        ##
        # Test whether the given period is older, newer or equal to this one.
        #
        # @return [Fixnum] 1 if period is older, -1 if newer, 0 if equal.
        #
        # @since 0.0.3
        #
        def <=>(period)
          if start_date > period.start_date
            1
          elsif start_date < period.start_date
            -1
          else
            0
          end
        end

        ##
        # Returns next period.
        #
        # @return [Period] the next period.
        #
        # @since 0.0.3
        #
        # @see Periods::Modules::Period#previous
        #
        # @example
        #
        #    period = Period.new('10.04.2015', '20.05.2015')
        #    period.next # => 21.05.2015 - 30.06.2015
        #
        def next
          self.class.new(start_date + days, end_date + days)
        end

        ##
        # Returns previous period.
        #
        # @return [Period] the previous period.
        #
        # @since 0.0.3
        #
        # @see Periods::Modules::Period#next
        #
        # @example
        #
        #    period = Period.new('10.04.2015', '20.05.2015')
        #    period.previous # => 28.02.2015 - 09.04.2015
        #
        def previous
          self.class.new(start_date - days, end_date - days)
        end

        ##
        # Returns number of days in period.
        #
        # @return [Fixnum] the number of days in period.
        #
        # @since 0.0.3
        #
        # @example
        #
        #    Period.new('10.04.2015', '20.05.2015').days # => 41
        #
        def days
          end_date.yday - start_date.yday + 1
        end

        ##
        # Test whether the given date or period is included in this one.
        #
        # @return [Boolean] true if date or period is included, false otherwise.
        #
        # @since 0.0.3
        #
        # @example
        #
        #    Period.new('10.04.2015', '20.05.2015').include?('10.04.2015') # => true
        #    Period.new('10.04.2015', '20.05.2015').include?('20.05.2015') # => true
        #    Period.new('10.04.2015', '20.05.2015').include?('09.04.2015') # => false
        #    Period.new('10.04.2015', '20.05.2015').include?('21.05.2015') # => false
        #
        #    Period.new('10.04.2015', '20.05.2015').include?(Period.new('10.04.2015', '20.05.2015')) # => true
        #    Period.new('10.04.2015', '20.05.2015').include?(Period.new('15.04.2015', '15.05.2015')) # => true
        #    Period.new('10.04.2015', '20.05.2015').include?(Period.new('09.04.2015', '20.05.2015')) # => false
        #    Period.new('10.04.2015', '20.05.2015').include?(Period.new('10.04.2015', '21.05.2015')) # => false
        #
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

        ##
        # Return string representation of period.
        #
        # @return [String] the string representation of period.
        #
        # @since 0.0.3
        #
        # @example
        #
        #    Period.new('10.04.2015', '20.05.2015').to_s # => '10.04.2015 -  20.05.2015'
        #
        def to_s
          "#{start_date.strftime("%d.%m.%Y")} - #{end_date.strftime("%d.%m.%Y")}"
        end

      end
    end
  end
end
