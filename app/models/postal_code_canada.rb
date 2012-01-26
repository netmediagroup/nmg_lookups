class PostalCodeCanada < ReadonlyActiveRecord
  establish_connection :lookups

  has_one :postal_code_area, :as => :countryable
end
