class Region < ReadonlyActiveRecord
  establish_connection :lookups

  belongs_to :country
  has_many :counties
  has_many :postal_codes

  scope :active, where(:active => true)
  scope :named_order, order("#{quoted_table_name}.`name`")
end
