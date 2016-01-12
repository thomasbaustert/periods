[![Build Status](https://travis-ci.org/thomasbaustert/periods.svg?branch=master)](https://travis-ci.org/thomasbaustert/periods)

# Periods

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

    period = Period.new(Date.new(2015,6,25), Date.new(2015,8,19))

The start and end date can be a string too:

    period = Period.new('25.06.2015', '19.08.2015')

For convenience a period can be passed too:

    period = Period.new('25.06.2015', '19.08.2015')
    ...
    period2 = Period.new(period)

All period models respond to the following interface:

    * start_year
    * end_year
    * days
    * next
    * previous
    * include?
    * Comparable (==, >=, >, <=, <)
    * to_s

The following parts support Ruby Range too:

`MonthlyPeriod`, `QuarterlyPeriod`, `HalfyearlyPeriod`, `YearlyPeriod`, 
`Month`, `Quarter`, `Halfyear` and `Year`.

Example:

    range = Month.for('01.01.2015')..Month.for('01.12.2015')
    range.to_a # => 12 Months from Jan 2015 til Dec 2015
    
Special period models may define additional methods like `months` (see below).

#### start_year

    period = Period.new('25.06.2015', '19.08.2016')
    period.start_year # => 2015
 
#### end_year 

    period = Period.new('25.06.2015', '19.08.2016')
    period.end_year # => 2016

#### days

    period = Period.new('25.06.2015', '19.08.2015')
    period.days # => 56

#### next

    period = Period.new('25.06.2015', '19.08.2015')
    period.next # => 20.08.2015 - 14.10.2015

#### previous

    period = Period.new('25.06.2015', '19.08.2015')
    period.previous # => 30.04.2015 - 24.06.2015

#### include?

Test whether a date or a period is included in the given period:

    period = Period.new('25.06.2015', '19.08.2015')
    period.include?(Date.new(2015,6,25)) # => true
    period.include?('25.06.2015') # => true
    period.include?('24.06.2015') # => false
    
    period.include?(Period.new('25.06.2015', '19.08.2015')) # => true
    period.include?(Period.new('26.06.2015', '19.08.2015')) # => true
    period.include?(Period.new('24.06.2015', '19.08.2015')) # => false
    period.include?(Period.new('25.06.2015', '20.08.2015')) # => false

### WeeklyPeriod

If you need a constant weekly range use `WeeklyPeriod`:

    weekly = WeeklyPeriod.for('25.06.2015') # => 25.06.2015 - 01.07.2015
    weekly.next     # => 02.07.2015 - 08.07.2015
    weekly.previous # => 18.06.2015 - 24.06.2015

### Week

Same as `WeeklyPeriod`:

    week = Week.for('25.06.2015') # => 25.06.2015 - 01.07.2015
    week.next     # => 02.07.2015 - 08.07.2015
    week.previous # => 18.06.2015 - 24.06.2015

### MonthlyPeriod

If you need a constant monthly range use `MonthlyPeriod`:

    monthly = MonthPeriod.for('25.06.2015') # => 25.06.2015 - 24.07.2015
    monthly.next     # => 25.07.2015 - 24.08.2015
    monthly.previous # => 25.05.2015 - 24.06.2015

### Month

If you need a calendar month starting at first day of month and ending at last day of month use `Month`:

    june = Month.for('25.06.2015') # => 01.06.2015 - 30.06.2015
    june.next     # => 01.07.2015 - 31.07.2015
    june.previous # => 01.05.2015 - 31.05.2015
    june.month    # => 6
    june.number   # => 6 (alias for month)
    june.year     # => 2015

### QuarterlyPeriod

A QuarterlyPeriod starts at given date and ends at last day three months later:

    period = QuarterlyPeriod.for('25.06.2015') # => 25.06.2015 - 24.09.2015

### Quarter

A Quarter starts at first day of a month and ends at last day three months later:

    quarter = Quarter.for('01.02.2015') # => 01.02.2015 - 30.04.2015
    quarter.next     # => 01.05.2015 - 31.07.2015
    quarter.previous # => 01.11.2014 - 31.01.2015
    
    quarter = Quarter.for('01.12.2015') # => 01.12.2015 - 29.02.2016
    quarter.months     # => [Month.for('01.12.2015'), Month.for('01.01.2016'), Month.for('01.02.2016')]

### HalfyearlyPeriod

A HalfyearlyPeriod starts at the given date and ends six month later:

    period = HalfyearlyPeriod.for('25.06.2015') # =>  25.06.2015 - 24.12.2015

### Halfyear

A Halfyear starts at the first day of a month and ends six month later:

    halfyear = HalfyearlyPeriod.for('25.06.2015') # =>  01.06.2015 - 30.11.2015
    halfyear.next       # => 25.12.2015 - 24.06.2016
    halfyear.previous   # => 25.12.2014 - 24.06.2015
    halfyear.months     # => [Month.for('01.06.2015'), ..., Month.for('01.11.2015')]

### YearlyPeriod

A YearlyPeriod starts at the given date and ends one year later:

    period = YearlyPeriod.for('25.06.2015') # => 25.06.2015 - 24.06.2016

### Year

A year starts at first day of a month and ends one year later:

    year = Year.for('01.02.2015') # => 01.02.2015 - 31.01.2016
    year.next       # => 01.02.2016 - 31.01.2017
    year.previous   # => 01.02.2014 - 31.01.2015
    year.months     # => [Month.for('01.02.2015'), ..., Month.for('01.01.2016')]
    year.quarters   # => [Quarter.for('01.02.2015'), ..., Quarter.for('01.11.2015')]
    
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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
