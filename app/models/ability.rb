class Ability
  include CanCan::Ability

  def initialize(user)
    user ||=User.new

    if user.role == 'consumer'
      can :see_middle_header, User
      can :search, User
      can :can_see_wishlist, User
      can :can_add_to_wishlist, User
      can :can_enquiry, User
      
    elsif user.role == 'supplier'
      can :see_dashboard, User
      can :see_mainboard, User
      can :edit_supplier, User
      can :see_notifications, User

    else  # not logged in
      can :see_middle_header
      can :search
    end

  end
end
