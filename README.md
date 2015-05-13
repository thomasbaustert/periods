# Periods

**This is work in progress, no gem released!**

Simple period types like Period, WeeklyPeriod, Week, Monthly, Quarter, Halfyear, Year.

## Installation

Add this line to your application's Gemfile:

    gem 'periods'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install periods

## Usage

Include `models` part of the gem in your app:

    require 'periods/models'

Include the `modules` part in case of name clashes (see below):

    require 'periods/modules'

### Period

A period is defined by a start and end date.

    period = Period.for('25.06.2015', '19.08.2015')
    period.days      # => 56
    period.next      # => 20.08.2015 - 14.10.2015
    period.next.days # => 56

All models respond to the following API:

    * next
    * previous
    * days
    * include?
    * comparing (==, >=, >, <=, <)
    * ...

### MonthlyPeriod

If you need a constant monthly range use `MonthlyPeriod`:

    monthly = MonthPeriod.for('01.01.2015') # => 01.01.2015 - 31.01.2015
    monthly.next # => 01.02.2015 - 28.02.2015

    monthly = MonthPeriod.for('25.06.2015') # => 25.06.2015 - 24.07.2015
    monthly.next        # => 25.07.2015 - 24.08.2015
    monthly.start_date  # Date(25.06.2015)
    monthly.end_date    # Date(24.07.2015)
    
### Month

If you need a calendar month starting at first day of month and ending at last day of month use `Month`:

    january = Month.for('01.01.2015') # => 01.01.2015 - 31.01.2015
    january.next # => 01.02.2015 - 28.02.2015

    june = MonthPeriod.for('25.06.2015') # => 01.06.2015 - 30.06.2015
    june.next   # => 01.07.2015 - 31.07.2015
    june.month  # => 6
    june.year   # => 2015

### QuarterlyPeriod

### Quarter

### HalfyearlyPeriod

### Halfyear

### Yearly

### Year

### If constants already exist

In case constants like `Month` already exist in your code you can write your own custom classes
by including the appropriate module:

    require 'periods/modules'

    class MyMonth
      include Periods::Month
    end
    month = MyMonth.for('01.08.2015')
    ...

    class MyQuarter
      include Periods::Quarter
    end
    quarter = MyQuarter.for('01.01.2015')
    ...

Ruby is cool!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
