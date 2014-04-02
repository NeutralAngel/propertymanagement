class Lease < ActiveRecord::Base
  belongs_to :unit
  has_many :renters, class_name: 'User'
  validates :rent, numericality: { only_integer: true }
end
