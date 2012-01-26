require "rails"

module NmgLookups
  class Railtie < Rails::Railtie
    config.nmg_lookups = ActiveSupport::OrderedOptions.new

    config.nmg_lookups.postal_code_lookup = ActiveSupport::OrderedOptions.new
    config.nmg_lookups.postal_code_lookup.activerecord_model = 'PostalCode'
    config.nmg_lookups.postal_code_lookup.activerecord_column_name = 'code'
    config.nmg_lookups.postal_code_lookup.lookup_enabled = false
    config.nmg_lookups.postal_code_lookup.lookup_class_name = ''
    config.nmg_lookups.postal_code_lookup.lookup_method_name = 'find'
  end
end
