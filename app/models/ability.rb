class Ability
  include CanCan::Ability

  def initialize(user)

    can :index, Company 
    can :show, Company
    if user.is_a? Admin
      can :manage, :all
    elsif user.is_a? Company 
      can :edit, Company, :id => user.id
      can :show, Company, :id => user.id
      can :update, Company, :id => user.id
      
    else
      can :send_email, Company
    end
  end
end