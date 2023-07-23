module Types
  class MutationType < Types::BaseObject
    field :sign_in, mutation: Mutations::SignInMutation
    field :create_user, mutation: Mutations::CreateUserMutation
    field :create_category, mutation: Mutations::CreateCategoryMutation
    field :post, mutation: Mutations::PostMutation
  end
end
