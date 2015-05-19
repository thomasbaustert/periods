require 'spec_helper'
require 'periods/constants'
require 'initialized_by_single_date'

describe MonthlyPeriod do

  let(:subject) { described_class.for("1.1.2015") }

  it_behaves_like "Initialized by single date" do
    let(:period) { described_class.for(Date.new(2015,6,25)) }
  end

  describe ".for" do
    context "Date given" do
      it "returns month of given date included" do
        month = described_class.for(Date.new(2015,6,25))

        expect(month.start_date).to eq Date('25.06.2015')
        expect(month.end_date).to eq Date('24.07.2015')
      end
    end

    context "String given" do
      it "returns month of given date included" do
        month = described_class.for('25.06.2015')

        expect(month.start_date).to eq Date('25.06.2015')
        expect(month.end_date).to eq Date('24.07.2015')
      end
    end

    context "MonthlyPeriod given" do
      it "returns month of given date included" do
        period = described_class.for(described_class.for('25.06.2015'))

        expect(period.start_date).to eq Date('25.06.2015')
        expect(period.end_date).to eq Date('24.07.2015')
      end
    end

    context "Period given" do
      it "raise exception" do
        expect {
          described_class.for(Period.new('25.06.2015', '24.07.2015'))
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#next" do
    it "returns next month" do
      expect(described_class.for('25.06.2015').next).to eq described_class.for('25.07.2015')
      expect(described_class.for('01.07.2015').next).to eq described_class.for('01.08.2015')
      expect(described_class.for('03.12.2015').next).to eq described_class.for('03.01.2016')
    end
  end

  describe "#previous" do
    it "returns previous month" do
      expect(described_class.for('25.06.2015').previous).to eq described_class.for('25.05.2015')
      expect(described_class.for('01.07.2015').previous).to eq described_class.for('01.06.2015')
      expect(described_class.for('03.01.2016').previous).to eq described_class.for('03.12.2015')
    end
  end

end