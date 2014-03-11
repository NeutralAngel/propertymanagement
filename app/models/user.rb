class User < ActiveRecord::Base
  acts_as_authentic
  belongs_to :lease
  has_and_belongs_to_many :roles
end
