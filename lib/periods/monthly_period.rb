require 'periods/modules/monthly_period'

##
# A monthly period starts one a day X in month and ends on one day before X in the next month,
# e.g. from 25.06.2015 to 24.07.2015
#
module Periods
  class MonthlyPeriod
    include Periods::Modules::MonthlyPeriod
  end
end

