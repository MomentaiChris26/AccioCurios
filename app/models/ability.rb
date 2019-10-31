# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all

    if user.present?  # additional permissions for logged in users (they can read their own posts)
      can [:new, :create, :edit, :update, :show, :destroy], Listing, user_id: user.id

      if user.admin?  # additional permissions for administrators
        can :manage, :all
      end
    end
  end
end
