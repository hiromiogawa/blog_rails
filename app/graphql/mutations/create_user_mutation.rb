module Mutations
  class CreateUserMutation < Mutations::BaseMutation
    argument :username, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true

    type Types::UserType

    def resolve(username:, email:, password:)
      User.create!(
        username: username,
        email: email,
        password: password,
      )
    end
  end
end
