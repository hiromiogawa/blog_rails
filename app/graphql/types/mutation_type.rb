module Types
  class MutationType < Types::BaseObject
    # サインイン
    field :sign_in, mutation: Mutations::SignInMutation

    # ユーザー
    field :create_user, mutation: Mutations::CreateUserMutation
    field :update_user, mutation: Mutations::UpdateUserMutation
    field :delete_user, mutation: Mutations::DeleteUserMutation
    field :delete_user, mutation: Mutations::DeleteUserMutation

    # カテゴリー
    field :create_category, mutation: Mutations::CreateCategoryMutation
    field :update_category, mutation: Mutations::UpdateCategoryMutation
    field :update_user_permissions, mutation: Mutations::UpdateUserPermissionsMutation

    # 投稿
    field :create_post, mutation: Mutations::CreatePostMutation
  end
end
