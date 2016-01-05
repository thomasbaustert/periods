require 'spec_helper'
require 'periods/constants'
require 'initialized_by_single_date'

describe Month do

  let(:subject) { described_class.for("1.1.2015") }

  it_behaves_like "Initialized by single date" do
    let(:period) { described_class.for(Date.new(2015,6,25)) }
  end

  describe "#next" do
    it "returns next month" do
      expect(described_class.for('25.06.2015').next).to eq described_class.for('01.07.2015')
      expect(described_class.for('01.07.2015').next).to eq described_class.for('01.08.2015')
      expect(described_class.for('01.12.2015').next).to eq described_class.for('01.01.2016')
    end
  end

  describe "#previous" do
    it "returns previous month" do
      expect(described_class.for('01.06.2015').previous).to eq described_class.for('01.05.2015')
      expect(described_class.for('01.07.2015').previous).to eq described_class.for('01.06.2015')
      expect(described_class.for('01.01.2016').previous).to eq described_class.for('01.12.2015')
    end
  end

  describe "#month" do
    it "returns month number" do
      expect(described_class.for('01.01.2015').month).to eq  1
      expect(described_class.for('01.06.2015').month).to eq  6
      expect(described_class.for('01.12.2015').month).to eq 12
    end
  end

  describe "#number" do
    it "returns month number" do
      expect(described_class.for('01.01.2015').number).to eq  1
      expect(described_class.for('01.06.2015').number).to eq  6
      expect(described_class.for('01.12.2015').number).to eq 12
    end
  end

  describe "#year" do
    it "returns year number" do
      expect(described_class.for('01.01.2015').year).to eq 2015
      expect(described_class.for('01.12.2015').year).to eq 2015
      expect(described_class.for('01.01.2014').year).to eq 2014
    end
  end

  describe "#to_s" do
    context "nothing passed" do
      it "returns period" do
        expect(described_class.for('01.03.2015').to_s).to eq "01.03.2015 - 31.03.2015"
        expect(described_class.for('01.06.2015').to_s).to eq "01.06.2015 - 30.06.2015"
      end
    end

    context ":month passed" do
      it "returns month.year" do
        expect(described_class.for('01.01.2015').to_s(:month)).to eq "01.2015"
        expect(described_class.for('01.06.2015').to_s(:month)).to eq "06.2015"
      end
    end
  end

  describe "Range" do
    it "works" do
      expect(range_to_months(Month.for("01.01.2015")..Month.for("31.01.2015"))).to eq new_months("01.01.2015",  1)
      expect(range_to_months(Month.for("01.01.2015")..Month.for("28.02.2015"))).to eq new_months("01.01.2015",  2)
      expect(range_to_months(Month.for("01.01.2015")..Month.for("26.08.2015"))).to eq new_months("01.01.2015",  8)
      expect(range_to_months(Month.for("01.01.2015")..Month.for("31.12.2015"))).to eq new_months("01.01.2015", 12)
      expect(range_to_months(Month.for("01.01.2015")..Month.for("31.05.2016"))).to eq new_months("01.01.2015", 17)
    end
  end

  def new_months(start_date, count)
    months = [Periods::Month.for(start_date)]
    month  = months.first.next
    2.upto(count) do |idx|
      months << month
      month = month.next
    end
    months
  end

  def range_to_months(range)
    range.inject([]) { |months, month| months << month }
  end

end