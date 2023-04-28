class Numeric
  def to_excel_string
    to_s.gsub(".", ",")
  end
end
