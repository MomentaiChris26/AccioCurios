# Model created by Cancancan for user authorisation
class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Listing # Sets permissions and authorisations for guests (users who aren't signed in)

    if user.present?  # Sets permissions and authorisations logged in users (they can read their own posts)
      can :manage, Listing, user_id: user.id
      can :create, Comment
      if user.admin?  # Sets permissions and authorisations for administrators
        can :manage, :all
      end
    end
  end
end
