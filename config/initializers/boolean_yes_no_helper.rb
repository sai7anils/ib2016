class TrueClass
  def to_yes_no
    "YES"
  end
end

class FalseClass
  def to_yes_no
    "NO"
  end
end

class NilClass
  def to_yes_no
    nil
  end
end

class String
  def to_yes_no
    if self == "1"
      "YES"
    else
      "NO"
    end
  end
end
