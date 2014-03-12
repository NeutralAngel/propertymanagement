class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud
    user ||= User.new
    if user.has_role? :manager
        can :crud, :all
        can :assign_roles, User
    elsif user.has_role? :renter
        can :crud, user
        can :index, :all
        can :create, RepairRequest
        can :crud, RepairRequest, submitter_id: user.id
    else
        can :index, User
    end
    can :create, :all
    can :destroy, UserSession
    can :close_request, RepairRequest if user.has_role? :manager
    can :open_request, RepairRequest if user.has_role? :renter
    
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
