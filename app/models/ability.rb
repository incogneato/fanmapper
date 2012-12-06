class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.is? :bar_owner
      can :show, :all
      can :create, Bar
      can :update, Bar do |bar|
        bar.try(:user) == user
      end
    else
      can :show, :all
    end
  end
end
