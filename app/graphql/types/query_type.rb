module Types
  class QueryType < Types::BaseObject
    
    # slugからカテゴリ1件取得
    field :category, Types::CategoryType, null: false do
      argument :slug, String, required: true
    end

    def category(slug:)
      Category.find_by(slug: slug)
    end

    # 指定した件数のcategoryを取得
    field :categories, [Types::CategoryType], null: false do
      argument :count, Integer, required: false
    end

    def categories(count: nil)
      count ? Category.limit(count) : Category.all
    end

    
    # idからユーザー1件取得
    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find_by(id: id)
    end

    # 指定した件数のuserを取得
    field :users, [Types::UserType], null: false do
      argument :count, Integer, required: false
    end

    def users(count: nil)
      count ? User.limit(count) : User.all
    end

    # idから記事を1件取得
    field :post, Types::PostType, null: false do
      argument :id, ID, required: true
    end

    def post(id:)
      Post.find_by(id: id)
    end

    # 指定した件数のpostを取得
    field :posts, [Types::PostType], null: false do
      argument :count, Integer, required: false
    end

    def posts(count: nil)
      count ? Post.limit(count) : Post.all
    end
  end
end
