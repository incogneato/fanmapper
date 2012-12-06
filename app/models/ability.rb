class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.bar_owner?
      can :show, :all
      can :manage, Bar, :user_id => user.id
    else
      can :show, :all
    end
  end
end
