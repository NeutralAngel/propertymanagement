class User < ActiveRecord::Base
  acts_as_authentic
  belongs_to :lease
  has_and_belongs_to_many :roles

  def has_role?(role_sym)
    roles.any? { |role| role.name.underscore.to_sym == role_sym }
  end
end
