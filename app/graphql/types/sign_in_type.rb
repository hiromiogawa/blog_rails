module Types
  class SignInType < Types::BaseObject
    field :user, Types::UserType, null: false
    field :jwt, String, null: false

    def jwt
      object[:jwt]
    end
  end
end