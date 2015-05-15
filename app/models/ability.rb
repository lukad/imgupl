class Ability
  include CanCan::Ability

  def initialize(user) # rubocop:disable Metrics/MethodLength
    user ||= User.new # guest user

    alias_action :read, :create, :destroy, to: :moderate

    case user.role
    when 'admin'
      can :manage, :all
    when 'mod'
      can :moderate, Upload
    when 'user'
      can [:read, :create], Upload
    when 'guest'
      can :read, Upload
    end
  end
end
