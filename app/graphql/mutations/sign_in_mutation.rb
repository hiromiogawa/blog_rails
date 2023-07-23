module Mutations
  class SignInMutation < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    type Types::SignInType

    def resolve(email:, password:)
      user = User.find_by(email: email)
      if user&.authenticate(password)
        token = JwtHelper.encode(user.id)
        { user: user, jwt: token }
      else
        raise GraphQL::ExecutionError, "Invalid username or password"
      end
    end
  end
end