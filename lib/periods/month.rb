module Periods
  module Month
    def self.included(base)
      base.class_eval do
        include Comparable
        include InstanceMethods
        extend ClassMethods
      end
    end

    module InstanceMethods
    end

    module ClassMethods
    end

  end
end