module Mutations
  class DeleteUserMutation < BaseMutation
    argument :id, ID, required: false

    type GraphQL::Types::Boolean

    def resolve(id: nil)
      user = context[:current_user]

      if user.nil?
        raise GraphQL::ExecutionError, "User not signed in"
      end

      # IDが提供された場合、管理者のみが他のユーザーを削除できるようにする
      if id
        raise GraphQL::ExecutionError, "Not authorized" unless user.has_permission?(:delete_users)

        user = User.find(id)
      end

      if user.destroy
        true
      else
        raise GraphQL::ExecutionError, "Failed to delete user"
      end
    end
  end
end