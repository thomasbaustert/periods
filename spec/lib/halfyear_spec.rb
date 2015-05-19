require 'spec_helper'
require 'periods/constants'
require 'initialized_by_single_date'

describe Halfyear do

  let(:subject) { described_class.for("1.1.2015") }

  it_behaves_like "Initialized by single date" do
    let(:period) { described_class.for(Date.new(2015,6,25)) }
  end

  describe ".for" do
    it "returns halfyear of given date included" do
      halfyear = described_class.for('25.06.2015')

      expect(halfyear.start_date).to eq Date('01.06.2015')
      expect(halfyear.end_date).to eq Date('30.11.2015')
    end
  end

  describe "#next" do
    it "returns next halfyear" do
      expect(described_class.for('25.06.2015').next).to eq described_class.for('01.12.2015')
      expect(described_class.for('01.07.2015').next).to eq described_class.for('01.01.2016')
    end
  end

  describe "#previous" do
    it "returns previous halfyear" do
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

  describe "#quarters" do
    it "returns quarters of halfyear" do
      expect(described_class.for('01.01.2015').quarters).
          to eq [ Quarter.for('01.01.2015'), Quarter.for('01.04.2015')]
      expect(described_class.for('01.06.2015').quarters).
          to eq [ Quarter.for('01.06.2015'), Quarter.for('01.09.2015')]
    end
  end
end