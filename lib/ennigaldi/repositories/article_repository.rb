class ArticleRepository < Hanami::Repository
  associations do
    has_many :images
  end

  def create_with_images(article)
    new_article = self.class.new.create(attributes(article))
    process_images(article, new_article)
  end

  private

  def attributes(article)
    {
      title: article.fetch('title'),
      description: article.fetch('contentSummary'),
      category: article.fetch('category'),
      significance: article.fetch('significance'),
      authors: authors(article)
    }
  end

  def process_images(article, new_article)
    images = article.fetch('media').select { |m| m['type'] == 'image' }
    images.each { |i| new_article.images.create(uri(i)) }
  end

  # default to medium for now
  def uri(image)
    image.dig('medium, uri')
  end

  def authors(article)
    article
      .fetch('authors')
      .map { |a| a['fullName'] }
      .join(', ')
  end
end
