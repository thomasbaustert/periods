shared_examples "Lint Check" do

  it "respond #next" do
    expect(subject).to respond_to(:next)
  end

  it "respond #previous" do
    expect(subject).to respond_to(:previous)
  end

  it "respond #days" do
    expect(subject).to respond_to(:days)
  end

  it "respond #:include?" do
    expect(subject).to respond_to(:include?)
  end

  it "is Comparable" do
    expect(subject).to be_kind_of(Comparable)
  end
end


