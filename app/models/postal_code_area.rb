class PostalCodeArea < ActiveRecord::Base
  establish_connection :lookups

  belongs_to :postal_code
  belongs_to :countryable, :polymorphic => true
  belongs_to :countryable_canada, :class_name => 'PostalCodeCanada', :foreign_key => 'countryable_id', :conditions => "#{PostalCodeArea.quoted_table_name}.`countryable_type` = 'PostalCodeCanada'"

  scope :allowed_city_types, where(["#{quoted_table_name}.`city_type` <> ?", 'N'])
  scope :default_city_type, where(["#{quoted_table_name}.`city_type` = ?", 'D'])
  scope :city_order, order("#{quoted_table_name}.`city`")
  scope :city_type_order, allowed_city_types.order("#{quoted_table_name}.`city_type` = 'D' DESC")

  def self.explain_city_type
    "In many cases, a ZIP Code can have multiple \"names\", meaning cities, towns, or subdivisions, in its boundaries. However, it will ALWAYS have exactly 1 \"default\" name.
  * D - Default - This is the \"preferred\" name - by the USPS - for a city. Each ZIP Code has one - and only one - \"default\" name. In most cases, this is what people who live in that area call the city as well.
  * A - Acceptable - This name can be used for mailing purposes. Often times alternative names are large neighborhoods or sections of the city/town. In some cases a ZIP Code may have several \"acceptable\" names which is used to group towns under one ZIP Code.
  * N - Not Acceptable - A \"not acceptable\" name is, in many cases, a nickname that residents give that location. According to the USPS, you should NOT send mail to that ZIP Code using the \"not acceptable\" name when mailing."
  end

  def self.explain_postal_type
    "The Canada Post has assigned each Postal Code a \"type\". Why? It helps them sort mail more quickly.
  * S - Standard - A \"standard\" ZIP Code is what most people think of when they talk about ZIP Codes - essentially a town, city, or a division of a city that has mail service.
  * P - PO Box Only - Rural towns, groups of towns, or even high-growth areas of cities are given a \"PO Box Only\" ZIP Code type.
  * U - Unique - Companies, organizations, and institutions that receive large quantities of mail are given a \"unique\" ZIP Code type.
  * M - Military - Military bases overseas - and often vessels and ships - are given a \"military\" ZIP Code type."
  end

end
