class QueryType < GraphQL::Schema::Object
  description "The query root of this schema"

  field :article, ArticleType, null: true do
    description "Find a article by ID"
    argument :id, ID, required: false
  end

  # Then provide an implementation:
  def article(id:)
    Article.find(id)
  end
end
