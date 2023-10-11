class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, :all
    can :destroy, Food, user_id: user.id
    can :destroy, Recipe, user_id: user.id
    can :create, Food if user.persisted?
    can :create, Recipe if user.persisted?
  end
end
