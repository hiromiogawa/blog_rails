module Mutations
  class CreateCategoryMutation < BaseMutation
    argument :name, String, required: true
    argument :slug, String, required: true

    type Types::CategoryType

    def resolve(name:, slug:)

      # ログインしているか確認する
      user = context[:current_user]
      if user.nil?
        raise GraphQL::ExecutionError, "User not signed in"
      end

      # カテゴリを作成する権限があるか確認する
      unless user.has_permission?(:post_categories)
        raise GraphQL::ExecutionError, "User does not have permission to create categories"
      end

      category = Category.new(name: name, slug: slug)
      if category.save
        category
      else
        raise GraphQL::ExecutionError, category.errors.full_messages.join(", ")
      end
    end
  end
end
