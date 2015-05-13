require 'spec_helper'

describe Month do

  let(:subject) { described_class.for("1.1.2015") }

  it_behaves_like "Lint Check"

  describe ".for" do
    it "returns month of given date included" do
      month = described_class.for('25.06.2015')

      expect(month.start_date).to eq date('01.06.2015')
      expect(month.end_date).to eq date('30.06.2015')
    end
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
end