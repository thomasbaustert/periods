shared_examples "Initialized by single date" do

  describe ".for" do

    context "Date given" do
      it "returns period based on given date" do
        expect(described_class.for(Date.new(2015,6,25))).to eq period
      end
    end

    context "String given" do
      it "returns period based on given date" do
        expect(described_class.for('25.06.2015')).to eq period
      end
    end

    context "same class given" do
      it "returns period based on given date" do
        expect(described_class.for(described_class.for('25.06.2015'))).to eq period
      end
    end

    context "Period given" do
      it "raise exception" do
        expect {
          described_class.for(Period.new('01.01.2015', '01.01.2015'))
        }.to raise_error(ArgumentError)
      end
    end
  end

end


