require 'spec_helper'

describe Period do

  describe "==" do
    context "same period given" do
      it "returns true" do
        expect(described_class.new("01.02.2015", "28.02.2015") == described_class.new("01.02.2015", "28.02.2015")).to be_truthy
      end
    end

    context "not same period given" do
      it "returns false" do
        expect(described_class.new("01.02.2015", "28.02.2015") == described_class.new("02.02.2015", "28.02.2015")).to be_falsey
        expect(described_class.new("01.02.2015", "28.02.2015") == described_class.new("01.02.2015", "27.02.2015")).to be_falsey
        expect(described_class.new("01.02.2015", "28.02.2015") == described_class.new("01.03.2015", "31.03.2015")).to be_falsey
      end
    end
  end

  describe "comparing" do
    it "compare correctly" do
      expect(described_class.new("01.02.2015", "28.02.2015") >= described_class.new("01.02.2015", "28.02.2015")).to be_truthy
      expect(described_class.new("01.02.2015", "28.02.2015") >  described_class.new("01.01.2015", "31.01.2015")).to be_truthy
      expect(described_class.new("01.02.2015", "28.02.2015") <= described_class.new("01.02.2015", "28.02.2015")).to be_truthy
      expect(described_class.new("01.02.2015", "28.02.2015") <  described_class.new("01.03.2015", "31.03.2015")).to be_truthy
    end
  end

  describe "#days" do
    it "returns days of period" do
      expect(described_class.new("01.02.2015", "28.02.2015").days).to eq 28
      expect(described_class.new("06.02.2015", "30.04.2015").days).to eq 84
    end
  end

  describe "#include?" do
    context "date included" do
      it "returns true" do
        expect(described_class.new("01.02.2015", "28.02.2015").include?("01.02.2015")).to be_truthy
        expect(described_class.new("01.02.2015", "28.02.2015").include?("28.02.2015")).to be_truthy
      end
    end

    context "date not included" do
      it "returns false" do
        expect(described_class.new("01.02.2015", "28.02.2015").include?("31.01.2015")).to be_falsey
        expect(described_class.new("01.02.2015", "28.02.2015").include?("01.03.2015")).to be_falsey
      end
    end
  end
end


