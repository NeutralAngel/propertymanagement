class Property < ActiveRecord::Base
  has_many :units

  def full_name
    "#{name} - #{address} #{city}, #{state} #{zip}"
  end
end
