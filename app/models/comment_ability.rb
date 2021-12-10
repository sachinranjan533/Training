class CommentAbility
    include CanCan::Ability
    def initialize(user)
        can [:ud], Comment do |comment|
            comment.user_id==user.id
        end
    end
  end