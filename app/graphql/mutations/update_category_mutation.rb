module Mutations
  class UpdateCategoryMutation < BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: false
    argument :slug, String, required: false

    type Types::CategoryType

    def resolve(id:, **attributes)

      # ログインしているか確認する
      user = context[:current_user]
      if user.nil?
        raise GraphQL::ExecutionError, "User not signed in"
      end

      # カテゴリを作成する権限があるか確認する
      unless user.has_permission?(:post_categories)
        raise GraphQL::ExecutionError, "User does not have permission to update categories"
      end
      
      category = Category.find(id)
      
      if category.update(attributes)
        category
      else
        raise GraphQL::ExecutionError, category.errors.full_messages.join(", ")
      end
    end
  end
end