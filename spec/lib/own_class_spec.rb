require 'spec_helper'
require 'periods/modules'

class MyMonth
  include Periods::Modules::Month
end

describe "defining own classes including period module" do

  describe ".for" do
    it "set start and end date" do
      month = MyMonth.for('25.06.2015')

      expect(month.start_date).to eq date('01.06.2015')
      expect(month.end_date).to eq date('30.06.2015')
    end
  end

end