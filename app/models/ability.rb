class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all

      can :home, :admin
      can :download, :admin
    else
      can :read, user
      can :reopen, User, user_id: user.id
      can :manage, user
      
      can :create, Asset, user_id: user.id
      can :destroy, Asset, user_id: user.id
    end
  end

end
