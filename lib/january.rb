class January < Month

  def self.of(year)
    January.for("1.1.#{year}")
  end

  def next
    January.for("1.1.#{year.to_i + 1}")
  end

  def previous
    January.for("1.1.#{year.to_i - 1}")
  end

  def month
    1
  end

  def year
    start_date.year
  end
end