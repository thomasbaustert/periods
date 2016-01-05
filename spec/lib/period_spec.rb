require 'spec_helper'
require 'periods/constants'

describe Period do

  def new_period(start_date, end_date)
    described_class.new(start_date, end_date)
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

  def new_quarters(start_date, count)
    quarters = [Periods::Quarter.for(start_date)]
    quarter  = quarters.first.next
    2.upto(count) do |idx|
      quarters << quarter
      quarter = quarter.next
    end
    quarters
  end

  def new_halfyears(start_date, count)
    halfyears = [Periods::Halfyear.for(start_date)]
    halfyear  = halfyears.first.next
    2.upto(count) do |idx|
      halfyears << halfyear
      halfyear = halfyear.next
    end
    halfyears
  end

  describe ".new" do
    it "accepts Date" do
      period = described_class.new(Date.new(2015,6,25), Date.new(2016,5,20))

      expect(period.start_date).to eq Date('25.06.2015')
      expect(period.end_date).to eq Date('20.05.2016')
    end

    it "accepts String" do
      period = described_class.new('25.06.2015', '20.05.2016')

      expect(period.start_date).to eq Date('25.06.2015')
      expect(period.end_date).to eq Date('20.05.2016')
    end

    it "raises error if end date is missing" do
      expect { described_class.new('25.06.2015', nil) }.to raise_error(ArgumentError)
    end

    it "accepts Period" do
      period = described_class.new(Period.new('25.06.2015', '20.05.2016'))

      expect(period.start_date).to eq Date('25.06.2015')
      expect(period.end_date).to eq Date('20.05.2016')
    end
  end

  describe "==" do
    context "same period given" do
      it "returns true" do
        expect(new_period("01.02.2015", "28.02.2015") == new_period("01.02.2015", "28.02.2015")).to be_truthy
      end
    end

    context "not same period given" do
      it "returns false" do
        expect(new_period("01.02.2015", "28.02.2015") == new_period("02.02.2015", "28.02.2015")).to be_falsey
        expect(new_period("01.02.2015", "28.02.2015") == new_period("01.02.2015", "27.02.2015")).to be_falsey
        expect(new_period("01.02.2015", "28.02.2015") == new_period("01.03.2015", "31.03.2015")).to be_falsey
      end
    end
  end

  describe "comparing" do
    it "compare correctly" do
      expect(new_period("01.02.2015", "28.02.2015") >= new_period("01.02.2015", "28.02.2015")).to be_truthy
      expect(new_period("01.02.2015", "28.02.2015") >  new_period("01.01.2015", "31.01.2015")).to be_truthy
      expect(new_period("01.02.2015", "28.02.2015") <= new_period("01.02.2015", "28.02.2015")).to be_truthy
      expect(new_period("01.02.2015", "28.02.2015") <  new_period("01.03.2015", "31.03.2015")).to be_truthy
    end
  end

  describe "#next" do
    it "returns next period" do
      expect(new_period("25.06.2015", "19.08.2015").next).to eq new_period("20.08.2015", "14.10.2015")
      expect(new_period("03.12.2015", "07.12.2015").next).to eq new_period("08.12.2015", "12.12.2015")
    end
  end

  describe "#previous" do
    it "returns previous period" do
      expect(new_period("25.06.2015", "19.08.2015").previous).to eq new_period("30.04.2015", "24.06.2015")
      expect(new_period("03.12.2015", "07.12.2015").previous).to eq new_period("28.11.2015", "02.12.2015")
    end
  end

  describe "#days" do
    it "returns days of period" do
      expect(new_period("25.06.2015", "19.08.2015").days).to eq 56
      expect(new_period("20.08.2015", "14.10.2015").days).to eq 56
      expect(new_period("01.02.2015", "28.02.2015").days).to eq 28
      expect(new_period("06.02.2015", "30.04.2015").days).to eq 84
    end
  end

  describe "#start_year" do
    it "returns start year of quarter" do
      expect(new_period("25.06.2015", "19.08.2015").start_year).to eq 2015
      expect(new_period("25.06.2015", "20.05.2016").start_year).to eq 2015
    end
  end

  describe "#end_year" do
    it "returns end year of quarter" do
      expect(new_period("25.06.2015", "19.08.2015").end_year).to eq 2015
      expect(new_period("25.06.2015", "20.05.2016").end_year).to eq 2016
    end
  end

  describe "#include?" do
    context "date included" do
      it "returns true" do
        expect(new_period("01.02.2015", "28.02.2015").include?(Date("01.02.2015"))).to be_truthy
        expect(new_period("01.02.2015", "28.02.2015").include?(Date("28.02.2015"))).to be_truthy
      end
    end

    context "date not included" do
      it "returns false" do
        expect(new_period("01.02.2015", "28.02.2015").include?(Date("31.01.2015"))).to be_falsey
        expect(new_period("01.02.2015", "28.02.2015").include?(Date("01.03.2015"))).to be_falsey
      end
    end

    context "date string included" do
      it "returns true" do
        expect(new_period("01.02.2015", "28.02.2015").include?("01.02.2015")).to be_truthy
        expect(new_period("01.02.2015", "28.02.2015").include?("28.02.2015")).to be_truthy
      end
    end

    context "date string not included" do
      it "returns false" do
        expect(new_period("01.02.2015", "28.02.2015").include?("31.01.2015")).to be_falsey
        expect(new_period("01.02.2015", "28.02.2015").include?("01.03.2015")).to be_falsey
      end
    end

    context "period included" do
      it "returns true" do
        period = new_period("10.04.2015", "20.05.2015")
        expect(period.include?(new_period("10.04.2015", "20.05.2015"))).to be_truthy
        expect(period.include?(new_period("11.04.2015", "20.05.2015"))).to be_truthy
        expect(period.include?(new_period("10.04.2015", "19.05.2015"))).to be_truthy
      end
    end

    context "period not included" do
      it "returns false" do
        period = new_period("10.04.2015", "20.05.2015")
        expect(period.include?(new_period("09.04.2015", "20.05.2015"))).to be_falsey
        expect(period.include?(new_period("10.04.2015", "21.05.2015"))).to be_falsey
      end
    end
  end

  describe "#to_s" do
    it "returns period" do
      expect(new_period("09.04.2015", "20.05.2015").to_s).to eq "09.04.2015 - 20.05.2015"
      expect(new_period("26.06.2014", "10.09.2015").to_s).to eq "26.06.2014 - 10.09.2015"
    end
  end

  describe "#months" do
    it "returns months included period" do
      expect(new_period("01.01.2015", "31.12.2015").months).to eq new_months("01.01.2015", 12)
      expect(new_period("17.04.2015", "26.08.2015").months).to eq new_months("01.04.2015",  5)
      expect(new_period("01.01.2015", "31.05.2016").months).to eq new_months("01.01.2015", 17)
      expect(new_period("08.02.2015", "09.02.2015").months).to eq new_months("01.02.2015",  1)
    end
  end

  describe "#quarters" do
    it "returns quarters included period" do
      expect(new_period("01.01.2015", "31.12.2015").quarters).to eq new_quarters("01.01.2015", 4)
      expect(new_period("17.04.2015", "26.08.2015").quarters).to eq new_quarters("01.04.2015", 1)
      expect(new_period("17.04.2015", "31.05.2015").quarters).to eq []
      expect(new_period("01.01.2015", "31.05.2016").quarters).to eq new_quarters("01.01.2015", 5)
    end
  end

  describe "#halfyears" do
    it "returns halfyears included period" do
      expect(new_period("01.01.2015", "31.12.2015").halfyears).to eq new_halfyears("01.01.2015", 2)
      expect(new_period("17.04.2015", "26.08.2015").halfyears).to eq []
      expect(new_period("01.01.2015", "31.05.2016").halfyears).to eq new_halfyears("01.01.2015", 2)
      expect(new_period("01.01.2015", "30.06.2016").halfyears).to eq new_halfyears("01.01.2015", 3)
      expect(new_period("01.01.2015", "20.07.2016").halfyears).to eq new_halfyears("01.01.2015", 3)
    end
  end

  describe "#years" do
    it "returns years included period" do
      expect(new_period("01.01.2015", "31.12.2015").years).to eq [Periods::Year.for("01.01.2015")]
      expect(new_period("17.04.2015", "26.08.2015").years).to eq []
      expect(new_period("01.01.2015", "31.05.2016").years).to eq [Periods::Year.for("01.01.2015")]
      expect(new_period("01.01.2015", "30.06.2016").years).to eq [Periods::Year.for("01.01.2015")]
      expect(new_period("01.01.2015", "31.12.2016").years).to eq [Periods::Year.for("01.01.2015"), Periods::Year.for("01.01.2016")]
    end
  end
end


