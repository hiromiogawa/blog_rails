module Mutations
  class CreateCategoryMutation < BaseMutation
    argument :name, String, required: true
    argument :slug, String, required: true

    type Types::CategoryType

    def resolve(name:, slug:)
      category = Category.new(name: name, slug: slug)
      if category.save
        category
      else
        raise GraphQL::ExecutionError, category.errors.full_messages.join(", ")
      end
    end
  end
end
