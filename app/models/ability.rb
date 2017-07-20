class Ability
  include CanCan::Ability

  def initialize(user)
    
    if user.is_a? Admin
      can :manage, :all
    elsif user.is_a? Company 
      can :edit, Company, :id => user.id
      can :show, Company, :id => user.id
      can :update, Company, :id => user.id
    end
  end
end