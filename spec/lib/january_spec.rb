require 'spec_helper'

# TODO/05.03.15/04:15/tb Experimental
describe January do

  let(:subject) { January.of(2015) }

  it_behaves_like "Lint Check"

  describe ".of" do
    it "returns January of given year" do
      expect(described_class.of(2014)).to eq Month.for('01.01.2014')
      expect(described_class.of(2015)).to eq Month.for('01.01.2015')
    end
  end

  describe "#next" do
    it "returns next month" do
      expect(described_class.of(2014).next).to eq described_class.of(2015)
      expect(described_class.of(2015).next).to eq described_class.of(2016)
    end
  end

  describe "#previous" do
    it "returns previous month" do
      expect(described_class.of(2014).previous).to eq described_class.of(2013)
      expect(described_class.of(2015).previous).to eq described_class.of(2014)
    end
  end

  describe "#month" do
    it "returns month number" do
      expect(described_class.of(2015).month).to eq  1
    end
  end

  describe "#year" do
    it "returns year number" do
      expect(described_class.of(2015).year).to eq 2015
      expect(described_class.of(2014).year).to eq 2014
    end
  end
end