class Unit < ActiveRecord::Base
  belongs_to :property
  has_many :leases

  def full_name
    "#{property.name}: #{name}"
  end
end
