module Mutations
  class DeleteCategoryMutation < BaseMutation
    argument :id, ID, required: true

    type GraphQL::Types::Boolean

    def resolve(id:)
      # ログインしているか確認
      user = context[:current_user]
      if user.nil?
        raise GraphQL::ExecutionError, "User not signed in"
      end

      # カテゴリを削除する権限があるか確認
      unless user.has_permission?(:delete_categories)
        raise GraphQL::ExecutionError, "User does not have permission to delete categories"
      end

      category = Category.find_by(id: id)
      
      # カテゴリが存在するか確認
      unless category
        raise GraphQL::ExecutionError, "Category not found"
      end

      # カテゴリの削除
      if category.destroy
        true  # 削除が成功した場合はtrueを返す
      else
        raise GraphQL::ExecutionError, "Failed to delete category"
      end
    end
  end
end