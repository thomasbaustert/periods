require 'spec_helper'
require 'periods/constants'

describe Quarter do

  let(:subject) { described_class.for("1.1.2015") }

  it_behaves_like "Lint Check"

  describe ".for" do
    it "returns quarter of given date included" do
      period = described_class.for('25.06.2015')

      expect(period.start_date).to eq Date('01.06.2015')
      expect(period.end_date).to eq Date('31.08.2015')
    end
  end

  describe "#next" do
    it "returns next quarter" do
      expect(described_class.for('25.06.2015').next).to eq described_class.for('25.09.2015')
      expect(described_class.for('01.06.2015').next).to eq described_class.for('01.09.2015')
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
    let(:period) { described_class.for('01.06.2015') }

    context "date included" do
      it "returns true" do
        expect(period.include?('25.06.2015')).to be_truthy
        expect(period.include?('26.06.2015')).to be_truthy
        expect(period.include?('01.07.2015')).to be_truthy
        expect(period.include?('30.08.2015')).to be_truthy
        expect(period.include?('31.08.2015')).to be_truthy
      end
    end

    context "date not included" do
      it "returns false" do
        expect(period.include?('31.05.2015')).to be_falsey
        expect(period.include?('01.09.2015')).to be_falsey
      end
    end

    context "month included" do
      it "returns true" do
        expect(period.include?(Month.for('01.06.2015'))).to be_truthy
        expect(period.include?(Month.for('01.07.2015'))).to be_truthy
        expect(period.include?(Month.for('01.08.2015'))).to be_truthy
      end
    end

    context "month not included" do
      it "returns false" do
        expect(period.include?(Month.for('01.05.2015'))).to be_falsey
        expect(period.include?(Month.for('01.09.2015'))).to be_falsey
      end
    end

    context "period included" do
      it "returns true" do
        expect(period.include?(Period.new('01.06.2015', '31.08.2015'))).to be_truthy
        expect(period.include?(Period.new('02.06.2015', '31.08.2015'))).to be_truthy
        expect(period.include?(Period.new('01.06.2015', '30.08.2015'))).to be_truthy
        expect(period.include?(Period.new('02.06.2015', '30.08.2015'))).to be_truthy
      end
    end

    context "period not included" do
      it "returns false" do
        expect(period.include?(Period.new('31.05.2015', '31.08.2015'))).to be_falsey
        expect(period.include?(Period.new('01.06.2015', '01.09.2015'))).to be_falsey
      end
    end
  end

  describe "#months" do
    it "returns months of quarter" do
      expect(described_class.for('01.06.2015').months).
          to eq [Month.for('01.06.2015'), Month.for('01.07.2015'), Month.for('01.08.2015')]
      expect(described_class.for('01.12.2015').months).
          to eq [Month.for('01.12.2015'), Month.for('01.01.2016'), Month.for('01.02.2016')]
    end
  end

end