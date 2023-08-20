module Mutations
  class UpdateUserPermissionsMutation < BaseMutation
    argument :user_id, ID, required: true
    argument :permissions, [String], required: true

    type Types::UserType

    def resolve(user_id:, permissions:)
      current_user = context[:current_user]

      if current_user.nil?
        raise GraphQL::ExecutionError, "User not signed in"
      end

      unless current_user.has_permission?(:edit_users)
        raise GraphQL::ExecutionError, "Not authorized to update permissions"
      end

      user = User.find(user_id)

      permissions.each do |permission|
        user.grant_permission!(permission)
      end

      if user.save
        user
      else
        raise GraphQL::ExecutionError, user.errors.full_messages.join(", ")
      end
    end
  end
end