# Periods

**This is work in progress, no gem released!**

This gem provides period types like 

  * Period, 
  * WeeklyPeriod, Week, 
  * MonthlyPeriod, Month, 
  * QuarterlyPeriod, Quarter,
  * HalfyearlyPeriod, Halfyear,
  * YearlyPeriod, Year.

## Installation

Add this line to your application's Gemfile:

    gem 'periods'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install periods

## Usage

Require `periods` in your app:

    require 'periods'

### Period

A period is defined by a start and end date:

    period = Period.for(Date.new(2015,6,25), Date.new(2015,8,19))
    period.days      # => 56
    period.next      # => 20.08.2015 - 14.10.2015
    period.next.days # => 56

The start and end date can be a string too:

    period = Period.for('25.06.2015', '19.08.2015')

All period models respond to the following interface:

    * next
    * previous
    * days
    * include?
    * comparing (==, >=, >, <=, <)
    * ...

Special period models may define additional methods (see below).

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

In case constants like `Month` already exist in your code stop requiring `periods` in your `Gemfile`:

    gem 'periods', require: false

Require the namespaced classes only:

    require 'periods/classes'

Use them like so:

    month = Periods::Month.for('01.08.2015')

Alternatively require the modules only:

    require 'periods/modules'

Write your own classes:

    class MyMonth
      include Periods::Modules::Month
    end
    month = MyMonth.for('01.08.2015')
    ...

## TODO

* Implement Week
* Use Time not Date
* Comment Code

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
