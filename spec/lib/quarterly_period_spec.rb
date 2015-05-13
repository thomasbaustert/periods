require 'spec_helper'

describe QuarterlyPeriod do

  let(:subject) { described_class.for("1.1.2015") }

  it_behaves_like "Lint Check"

  describe ".for" do
    it "returns month of given date included" do
      period = described_class.for('25.06.2015')

      expect(period.start_date).to eq date('25.06.2015')
      expect(period.end_date).to eq date('24.09.2015')
    end
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

end