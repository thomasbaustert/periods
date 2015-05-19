require 'spec_helper'
require 'periods/constants'
require 'initialized_by_single_date'

describe QuarterlyPeriod do

  let(:subject) { described_class.for("1.1.2015") }

  it_behaves_like "Initialized by single date" do
    let(:period) { described_class.for(Date.new(2015,6,25)) }
  end

  describe "#next" do
    it "returns next quarter" do
      expect(described_class.for('25.06.2015').next).to eq described_class.for('25.09.2015')
      expect(described_class.for('01.07.2015').next).to eq described_class.for('01.10.2015')
      expect(described_class.for('03.12.2015').next).to eq described_class.for('03.03.2016')
    end
  end

  describe "#previous" do
    it "returns previous quarter" do
      expect(described_class.for('25.06.2015').previous).to eq described_class.for('25.03.2015')
      expect(described_class.for('01.07.2015').previous).to eq described_class.for('01.04.2015')
      expect(described_class.for('03.01.2016').previous).to eq described_class.for('03.10.2015')
    end
  end

  describe "#days" do
    it "returns days of period" do
      expect(described_class.for("25.06.2015").days).to eq 92
      expect(described_class.for("01.01.2015").days).to eq 90
      expect(described_class.for("01.01.2016").days).to eq 91
    end
  end

  describe "#include?" do
    let(:period) { described_class.for('25.06.2015') }

    context "date included" do
      it "returns true" do
        expect(period.include?('25.06.2015')).to be_truthy
        expect(period.include?('26.06.2015')).to be_truthy
        expect(period.include?('01.07.2015')).to be_truthy
        expect(period.include?('01.08.2015')).to be_truthy
        expect(period.include?('24.09.2015')).to be_truthy
      end
    end

    context "date not included" do
      it "returns false" do
        expect(period.include?('24.06.2015')).to be_falsey
        expect(period.include?('25.09.2015')).to be_falsey
      end
    end

    context "period included" do
      it "returns true" do
        expect(period.include?(Period.new('25.06.2015', '24.09.2015'))).to be_truthy
        expect(period.include?(Period.new('26.06.2015', '23.09.2015'))).to be_truthy
        expect(period.include?(Period.new('02.08.2015', '20.08.2015'))).to be_truthy
        expect(period.include?(Period.new('23.09.2015', '24.09.2015'))).to be_truthy
      end
    end

    context "period not included" do
      it "returns false" do
        expect(period.include?(Period.new('24.06.2015', '24.09.2015'))).to be_falsey
        expect(period.include?(Period.new('25.06.2015', '25.09.2015'))).to be_falsey
        expect(period.include?(Period.new('24.06.2015', '25.09.2015'))).to be_falsey
      end
    end
  end
end