require 'spec_helper'
require 'periods/date_calculator'

module Periods
  describe DateCalculator do

    describe "#beginning_of_month" do
      it "returns given date with first day of month" do
        expect(described_class.new('01.06.2015').beginning_of_month).to eq date('01.06.2015')
        expect(described_class.new('02.06.2015').beginning_of_month).to eq date('01.06.2015')
        expect(described_class.new('30.06.2015').beginning_of_month).to eq date('01.06.2015')
      end
    end

    describe "#end_of_month" do
      it "returns given date with last day of month" do
        expect(described_class.new('01.06.2015').end_of_month).to eq date('30.06.2015')
        expect(described_class.new('02.06.2015').end_of_month).to eq date('30.06.2015')
        expect(described_class.new('30.06.2015').end_of_month).to eq date('30.06.2015')
      end
    end
  end
end

