class ReadonlyActiveRecord < ActiveRecord::Base

  def readonly?
    return true
  end

  def before_destroy
    raise ActiveRecord::ReadOnlyRecord
  end

  def self.delete_all
    raise ActiveRecord::ReadOnlyRecord
  end

  def delete
    raise ActiveRecord::ReadOnlyRecord
  end

end
