class Ability
  include CanCan::Ability

  def initialize(account)
    account ||= Account.new # guest account

    if account.role?(:super_admin)
      can :manage, :all
    end

    if account.role?(:contest_admin)
      can [:read, :update], Contest do |contest|
        contest.contest_category.admins.include? account
      end
      can [:read, :update], Page do |page|
        page.contest.contest_category.admins.include? account
      end
      can [:read, :update], FormFormation do |form_formation|
        form_formation.contest.contest_category.admins.include? account
      end
      can [:read, :update], ProductCategory do |product_category|
        product_category.contest.contest_category.admins.include? account
      end
      can [:read, :update, :destroy], Product do |product|
        product.contest.contest_category.admins.include? account
      end
      can [:read, :update, :destroy], Profile do |profile|
        profile.product.contest.contest_category.admins.include? account
      end
      can :manage, Post
    end

    if account.role?(:judge)
      can :read, [Contest, Post]
      can :read, Product do |product|
        product.judges.include? account
      end
      can :update, Result do |result|
        result.judge == account
      end
    end

    if account.role?(:user)
      can :read, [Contest, Post]
      can :create, Product
      can [:read, :update], Product do |product|
        product.accounts.include? account
      end
      can :create, Profile
      can [:read, :update, :destroy], Profile do |profile|
        profile.product.accounts.include? account
      end
    end

    can :read, [Contest, Post]

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
