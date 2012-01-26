class Country < ReadonlyActiveRecord
  establish_connection :lookups

  has_many :regions

  scope :active, where(:active => true)
  scope :named_order, order("#{quoted_table_name}.`name`")
  scope :us_first, order("#{quoted_table_name}.`iso_3166_1_alpha_2` = 'US' DESC")

  def has_counties?
    [1,3].include?(id)
  end

end
