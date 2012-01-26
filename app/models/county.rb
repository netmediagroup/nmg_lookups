class County < ReadonlyActiveRecord
  establish_connection :lookups

  belongs_to :region
  has_many :postal_code_usas
  has_many :postal_code_areas, :through => :postal_code_usas, :class_name => "PostalCodeArea", :uniq => true
  # has_many :postal_codes, :through => :postal_code_areas

  scope :named_order, order("#{quoted_table_name}.`name`")

  def postal_codes
    postal_codes = postal_code_areas.collect {|postal_code_area| postal_code_area.postal_code_id }
    PostalCode.where(:id => postal_codes)
  end

end
