require 'spec_helper'
require 'periods/constants'
require 'initialized_by_single_date'

describe Year do

  let(:subject) { described_class.for("1.1.2015") }

  it_behaves_like "Lint Check"
  it_behaves_like "Initialized by single date" do
    let(:period) { described_class.for(Date.new(2015,6,25)) }
  end

  describe "#next" do
    it "returns next year" do
      expect(described_class.for('25.06.2015').next).to eq described_class.for('01.06.2016')
      expect(described_class.for('01.07.2015').next).to eq described_class.for('01.07.2016')
    end
  end

  describe "#previous" do
    it "returns previous year" do
      expect(described_class.for('25.06.2015').previous).to eq described_class.for('01.06.2014')
      expect(described_class.for('01.06.2015').previous).to eq described_class.for('01.06.2014')
    end
  end

  describe "#months" do
    it "returns months of year" do
      expect(described_class.for('01.06.2015').months).
          to eq [ Month.for('01.06.2015'), Month.for('01.07.2015'), Month.for('01.08.2015'),
                  Month.for('01.09.2015'), Month.for('01.10.2015'), Month.for('01.11.2015'),
                  Month.for('01.12.2015'), Month.for('01.01.2016'), Month.for('01.02.2016'),
                  Month.for('01.03.2016'), Month.for('01.04.2016'), Month.for('01.05.2016')
                ]
    end
  end

  describe "#quarters" do
    it "returns quarters of year" do
      expect(described_class.for('01.01.2015').quarters).
          to eq [ Quarter.for('01.01.2015'), Quarter.for('01.04.2015'),
                  Quarter.for('01.07.2015'), Quarter.for('01.10.2015')]
      expect(described_class.for('01.06.2015').quarters).
          to eq [ Quarter.for('01.06.2015'), Quarter.for('01.09.2015'),
                  Quarter.for('01.12.2015'), Quarter.for('01.03.2016')]
    end
  end
end