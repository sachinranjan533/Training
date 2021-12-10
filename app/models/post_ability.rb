class PostAbility
    include CanCan::Ability
    def initialize(user)
        can [:ud], Post do |post|
            post.user_id==user.id
        end
    end
  end