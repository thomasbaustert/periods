require 'spec_helper'
require 'periods/constants'

describe Period do

  def new_period(start_date, end_date)
    described_class.new(start_date, end_date)
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

  describe "#include?" do
    context "date included" do
      it "returns true" do
        expect(new_period("01.02.2015", "28.02.2015").include?("01.02.2015")).to be_truthy
        expect(new_period("01.02.2015", "28.02.2015").include?("28.02.2015")).to be_truthy
      end
    end

    context "date not included" do
      it "returns false" do
        expect(new_period("01.02.2015", "28.02.2015").include?("31.01.2015")).to be_falsey
        expect(new_period("01.02.2015", "28.02.2015").include?("01.03.2015")).to be_falsey
      end
    end
  end
end

