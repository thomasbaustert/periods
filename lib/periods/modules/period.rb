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
        #    period = Period.new(Date.new(2015,4,10), Date.new(2015,5,20))
        #    period = Period.new('10.04.2015', '20.05.2015')
        #    period = Period.new(Period.new('10.04.2015', '20.05.2015'))
        #
        def initialize(start_date, end_date = nil)
          if start_date.is_a?(Period)
            @start_date = start_date.start_date
            @end_date = start_date.end_date
          elsif end_date.nil?
            raise ArgumentError, "Period is missing end_date, e.g. Period.new(start_date, end_date)."
          else
            @start_date = Date.parse(start_date.to_s)
            @end_date = Date.parse(end_date.to_s)
          end
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
        # Returns start year of period.
        #
        # @return [Fixnum] start year of period.
        #
        # @since 0.0.3
        #
        # @example
        #
        #    Period.new('10.04.2015', '20.05.2016').start_year # => 2015
        #
        def start_year
          start_date.year
        end

        ##
        # Returns end year of period.
        #
        # @return [Fixnum] end year of period.
        #
        # @since 0.0.3
        #
        # @example
        #
        #    Period.new('10.04.2015', '20.05.2016').end_year # => 2016
        #
        def end_year
          end_date.year
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

        ##
        # Returns the months included in this period including the month of the start and end date
        # of this period.
        #
        # @return [Month] an array of months included in this period.
        #
        # @since 0.0.7
        #
        # @example
        #
        #    Period.new('01.01.2015', '31.12.2015').months # => Jan, Feb, ..., Dec
        #    Period.new('17.04.2015', '26.08.2015').months # => Apr, Mai, Jun, Jul, Aug
        #
        def months
          months = [Periods::Month.for(start_date)]
          month  = months.first.next
          while month <= Periods::Month.for(end_date)
            months << month
            month = month.next
          end
          months
        end

        ##
        # Returns the quarters included in this period including the quarter of the start date
        # of this period. The quarter of the end date of this period is only included if the
        # quarter's end date is before/equal the end date of this period.
        #
        # @return [Quarter] an array of quarters included in this period.
        #
        # @since 0.0.7
        #
        # @example
        #
        #    Period.new('01.01.2015', '31.12.2015').quarters # => (J,F,M),(A,M,J),(J,A,S),(O,N,D)
        #    Period.new('17.04.2015', '26.08.2015').quarters # => (A,M,J) but not (J,A,S)
        #
        def quarters
          quarters = [Periods::Quarter.for(start_date)]
          quarter  = quarters.first.next
          while quarter.end_date <= end_date
            quarters << quarter
            quarter = quarter.next
          end
          quarters
        end

        ##
        # Returns the halfyears included in this period including the halfyear of the start date
        # of this period. The halfyear of the end date of this period is only included if the
        # halfyear's end date is before/equal the end date of this period.
        #
        # @return [Halfyear] an array of halfyears included in this period.
        #
        # @since 0.0.7
        #
        # @example
        #
        #    Period.new('01.01.2015', '31.12.2015').halfyears # => (Jan-Jun),(Jul-Dec)
        #    Period.new('17.04.2015', '26.08.2015').halfyears # => []
        #    Period.new('01.01.2015', '31.05.2016').halfyears # => (Jan-Jun),(Jul-Dec)
        #    Period.new('01.01.2015', '30.06.2016').halfyears # => (Jan-Jun),(Jul-Dec),(Jan-Jun)
        #
        def halfyears
          halfyears = []
          halfyear  = Periods::Halfyear.for(start_date)
          while halfyear.end_date <= end_date
            halfyears << halfyear
            halfyear = halfyear.next
          end
          halfyears
        end

        ##
        # Returns the years included in this period including the year of the start date
        # of this period. The year of the end date of this period is only included if the
        # year's end date is before/equal the end date of this period.
        #
        # @return [Year] an array of halfyears included in this period.
        #
        # @since 0.0.7
        #
        # @example
        #
        #    Period.new('01.01.2015', '31.12.2015').halfyears # => [(Jan-Dec)]
        #    Period.new('17.04.2015', '26.08.2015').halfyears # => []
        #    Period.new('01.01.2015', '31.05.2016').halfyears # => [(Jan-Dec)]
        #    Period.new('01.01.2015', '31.12.2016').halfyears # => [(Jan-Dec),(Jan-Dec)]
        #
        def years
          years = []
          year  = Periods::Year.for(start_date)
          while year.end_date <= end_date
            years << year
            year = year.next
          end
          years
        end
      end
    end
  end
end
