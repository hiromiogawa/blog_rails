module Mutations
  class PostMutation < Mutations::BaseMutation
    argument :title, String, required: true
    argument :content, String, required: true
    argument :user_id, ID, required: true
    argument :category_id, ID, required: true

    type Types::PostType

    def resolve(title:, content:, user_id:, category_id:)

      # ログインしているか確認する
      if context[:current_user].nil?
        raise GraphQL::ExecutionError, "User not signed in"
      end

      user = User.find(user_id)
      category = Category.find(category_id)

      Post.create!(
        title: title,
        content: content,
        user: user,
        category: category
      )
    end
  end
end
