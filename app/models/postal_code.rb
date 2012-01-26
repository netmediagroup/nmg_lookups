class PostalCode < ActiveRecord::Base
  establish_connection :lookups

  FORMAT_CANADIAN_POSTAL_CODE = '^[a-z]\d[a-z]( ?\d[a-z]\d)?$'
  FORMAT_US_POSTAL_CODE = '^\d{5}([\-]\d{4})?$'
  CANADA_POSTAL_CODE_REGEXP = Regexp.new(FORMAT_CANADIAN_POSTAL_CODE, Regexp::IGNORECASE)
  US_POSTAL_CODE_REGEXP = Regexp.new(FORMAT_US_POSTAL_CODE, Regexp::IGNORECASE)
  US_OR_CANADA_POSTAL_CODE_REGEXP = Regexp.new("(#{FORMAT_US_POSTAL_CODE})|(#{FORMAT_CANADIAN_POSTAL_CODE})", Regexp::IGNORECASE)

  belongs_to :region
  has_many :postal_code_areas

  scope :code_order, order("#{quoted_table_name}.`code`")

  def self.normalize_postal_code(code)
    normalized_code = nil
    normalized_code = code[0,5] if code =~ US_POSTAL_CODE_REGEXP
    normalized_code = "#{code[0,3]}#{" #{code[-3,3]}" if code.size >= 6 }".upcase if code =~ CANADA_POSTAL_CODE_REGEXP
    normalized_code
  end

  def self.searchable_code(code)
    code = normalize_postal_code(code)
    code = code[0,3] if code && code =~ CANADA_POSTAL_CODE_REGEXP
    code
  end

  def cities
    postal_code_areas.city_order.collect{|a| a.city }.uniq
  end

  def self.lookup(code, force = false)
    postal_code = find_or_initialize_by_code(normalize_postal_code(code))
    if postal_code.new_record? || force
      postal_code.send(:perform_lookup)
      postal_code.save if postal_code.valid?
    end
    return postal_code.new_record? ? nil : postal_code
  end

protected

  def perform_lookup
    if Rails.application.config.nmg_lookups.postal_code_lookup.lookup_enabled && self.valid?
      NmgLookups::PostalCode.find(self)
    end
  end

end