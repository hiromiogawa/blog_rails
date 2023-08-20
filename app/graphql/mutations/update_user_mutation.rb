module Mutations
  class UpdateUserMutation < BaseMutation
    argument :id, ID, required: false
    argument :username, String, required: false
    argument :email, String, required: false
    argument :password, String, required: false

    type Types::UserType

    def resolve(id: nil, **attributes)
      user = context[:current_user]

      if user.nil?
        raise GraphQL::ExecutionError, "User not signed in"
      end

      # IDが提供された場合、管理者のみが他のユーザーの情報を更新できるようにする
      if id
        raise GraphQL::ExecutionError, "Not authorized" unless user.has_permission?(:edit_users)

        user = User.find(id)
      end

      if user.update(attributes)
        user
      else
        raise GraphQL::ExecutionError, user.errors.full_messages.join(", ")
      end
    end
  end
end