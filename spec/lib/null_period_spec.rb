require 'spec_helper'
require 'periods/constants'

describe NullPeriod do

  def new_period(*args)
    described_class.new(*args)
  end

  describe ".new" do
    it "returns instance with not defined dates" do
      period = described_class.new('25.06.2015', '20.05.2016')

      expect(period.start_date).to be_nil
      expect(period.end_date).to be_nil
    end
  end

  describe "==" do
    context "same period given" do
      it "returns true" do
        expect(new_period == new_period).to be_truthy
      end
    end

    context "not same period given" do
      it "returns false" do
        expect(new_period("02.02.2015", "28.02.2015") == Period.new("02.02.2015", "28.02.2015")).to be_falsey
      end
    end
  end

  describe "comparing" do
    it "compare correctly" do
      expect(new_period("01.02.2015", "28.02.2015") >= new_period("01.02.2015", "28.02.2015")).to be_truthy
      expect(new_period("01.02.2015", "28.02.2015") >  new_period("01.01.2015", "31.01.2015")).to be_falsey
      expect(new_period("01.02.2015", "28.02.2015") <= new_period("01.02.2015", "28.02.2015")).to be_truthy
      expect(new_period("01.02.2015", "28.02.2015") <  new_period("01.03.2015", "31.03.2015")).to be_falsey
    end
  end

  describe "#next" do
    it "returns next period" do
      expect(new_period.next).to eq new_period
    end
  end

  describe "#previous" do
    it "returns previous period" do
      expect(new_period.previous).to eq new_period
    end
  end

  describe "#days" do
    it "returns days of period" do
      expect(new_period("25.06.2015", "19.08.2015").days).to eq 0
    end
  end

  describe "#start_year" do
    it "returns start year of quarter" do
      expect(new_period("25.06.2015", "19.08.2015").start_year).to eq 0
    end
  end

  describe "#end_year" do
    it "returns end year of quarter" do
      expect(new_period("25.06.2015", "20.05.2016").end_year).to eq 0
    end
  end

  describe "#include?" do
    context "date included" do
      it "returns true" do
        expect(new_period("01.02.2015", "28.02.2015").include?(Date("01.02.2015"))).to be_falsey
      end
    end

  end
end


