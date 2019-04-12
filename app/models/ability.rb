# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize user
    can :read, [Product, Comment]
    return unless user
    can :manage, Comment, user_id: user.id
    can [:create, :destroy], OrderDetail
    if user.admin?
      can :manage, :all
      cannot :update, Comment do |comment|
        comment.user_id != user.id
      end
    elsif user.normal?
      can [:create, :read, :destroy, :update], Order, user_id: user.id
      cannot :destroy, Order, user_id: user.id, status: 2
      can :create, Suggestion
      can :read, Product
      can :read, User, id: user.id
    end
  end
end
