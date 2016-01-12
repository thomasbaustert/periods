require 'spec_helper'
require 'periods/constants'
require 'initialized_by_single_date'

describe WeeklyPeriod do

  let(:subject) { described_class.for("1.1.2015") }

  it_behaves_like "Initialized by single date" do
    let(:period) { described_class.for(Date.new(2015,6,25)) }
  end

  describe "#next" do
    it "returns next period" do
      expect(described_class.for('25.06.2015').next).to eq described_class.for('02.07.2015')
      expect(described_class.for('01.07.2015').next).to eq described_class.for('08.07.2015')
    end
  end

  describe "#previous" do
    it "returns previous period" do
      expect(described_class.for('25.06.2015').previous).to eq described_class.for('18.06.2015')
      expect(described_class.for('01.07.2015').previous).to eq described_class.for('24.06.2015')
    end
  end

  describe "#days" do
    it "returns days of period" do
      expect(described_class.for("01.01.2015").days).to eq 7
      expect(described_class.for("25.06.2015").days).to eq 7
      expect(described_class.for("01.01.2016").days).to eq 7
      expect(described_class.for("01.03.2016").days).to eq 7
    end
  end

  describe "#include?" do
    let(:period) { described_class.for('25.06.2015') }

    context "date included" do
      it "returns true" do
        puts period
        expect(period.include?('25.06.2015')).to be_truthy
        expect(period.include?('01.07.2015')).to be_truthy
      end
    end

    context "date not included" do
      it "returns false" do
        expect(period.include?('24.06.2015')).to be_falsey
        expect(period.include?('02.07.2015')).to be_falsey
      end
    end

    context "period included" do
      it "returns true" do
        expect(period.include?(Period.new('25.06.2015', '25.06.2015'))).to be_truthy
        expect(period.include?(Period.new('25.06.2015', '01.07.2015'))).to be_truthy
        expect(period.include?(Period.new('26.06.2015', '01.07.2015'))).to be_truthy
        expect(period.include?(Period.new('25.06.2015', '30.06.2015'))).to be_truthy
      end
    end

    context "period not included" do
      it "returns false" do
        expect(period.include?(Period.new('24.06.2015', '02.07.2015'))).to be_falsey
        expect(period.include?(Period.new('25.06.2015', '02.07.2015'))).to be_falsey
        expect(period.include?(Period.new('24.06.2015', '02.07.2015'))).to be_falsey
      end
    end
  end
end