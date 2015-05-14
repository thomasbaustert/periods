require 'spec_helper'
require 'periods/constants'

describe Halfyear do

  let(:subject) { described_class.for("1.1.2015") }

  it_behaves_like "Lint Check"

  describe ".for" do
    it "returns month of given date included" do
      month = described_class.for('25.06.2015')

      expect(month.start_date).to eq date('01.06.2015')
      expect(month.end_date).to eq date('30.11.2015')
    end
  end

  describe "#next" do
    it "returns next month" do
      expect(described_class.for('25.06.2015').next).to eq described_class.for('01.12.2015')
      expect(described_class.for('01.07.2015').next).to eq described_class.for('01.01.2016')
    end
  end

  describe "#previous" do
    it "returns previous month" do
      expect(described_class.for('25.06.2015').previous).to eq described_class.for('01.12.2014')
      expect(described_class.for('01.07.2015').previous).to eq described_class.for('01.01.2015')
    end
  end

  describe "#months" do
    it "returns months of year" do
      expect(described_class.for('01.06.2015').months).
          to eq [ Month.for('01.06.2015'), Month.for('01.07.2015'), Month.for('01.08.2015'),
                  Month.for('01.09.2015'), Month.for('01.10.2015'), Month.for('01.11.2015')
                ]
    end
  end
end