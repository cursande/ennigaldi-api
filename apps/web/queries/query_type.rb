class QueryType < GraphQL::Schema::Object
  description 'The query root of this schema'

  field :articles, [ArticleType], null: true do
    description 'Find all articles'
  end

  field :article, ArticleType, null: true do
    description 'Find an article by ID'
    argument :id, ID, required: true
  end

  def articles
    article_repo.all
  end

  def article(id:)
    article_repo.find_with_images(id)
  end

  private

  def article_repo
    @article_repo ||= ArticleRepository.new
  end
end
