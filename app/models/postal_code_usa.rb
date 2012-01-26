class PostalCodeUsa < ReadonlyActiveRecord
  establish_connection :lookups

  has_one :postal_code_area, :as => :countryable
  belongs_to :county
end
