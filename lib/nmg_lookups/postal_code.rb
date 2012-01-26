module NmgLookups::PostalCode
  class << self

    def find(postal_code)
      return nil if Rails.application.config.nmg_lookups.postal_code_lookup.lookup_enabled == false

      begin
        return lookup_class_name.send(lookup_method_name, postal_code)
      end
    end

    def activerecord_model
      Rails.application.config.nmg_lookups.postal_code_lookup.activerecord_model.constantize rescue nil
    end

    def activerecord_column_name
      Rails.application.config.nmg_lookups.postal_code_lookup.activerecord_column_name rescue nil
    end

    def lookup_class_name
      Rails.application.config.nmg_lookups.postal_code_lookup.lookup_class_name.constantize rescue nil
    end

    def lookup_method_name
      Rails.application.config.nmg_lookups.postal_code_lookup.lookup_method_name rescue nil
    end

  end
end
