require 'periods/date_calculator'
require 'periods/modules/weekly_period'

module Periods
  module Modules
    module Week

      def self.included(base)
        base.class_eval do
          include Periods::Modules::WeeklyPeriod
          include InstanceMethods
        end
      end

      module InstanceMethods

        private

      end
    end
  end
end
