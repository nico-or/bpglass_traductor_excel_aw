# frozen_string_literal: true

module Utilities
  # replaces decimal notation for spanish compatible
  def self.number_to_excel_string(number)
    number
      .round(1)
      .to_s
      .gsub('.', ',')
  end

  def self.normalize_text(text)
    text
      .strip
      .downcase
      .gsub(/\s+/, ' ')
  end
end
