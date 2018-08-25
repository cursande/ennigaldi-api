class ArticleRepository < Hanami::Repository
  associations do
    has_many :images
  end

  def create_with_images(article)
    new_article = self.create(attributes(article))
    process_images(article, new_article)
  end

  private

  def attributes(article)
    {
      title: article.fetch('title'),
      content: article.fetch('content'),
      content_summary: article.fetch('contentSummary'),
      types: types(article),
      authors: authors(article)
    }
  end

  def process_images(article, new_article)
    images = article.fetch('media').select { |m| m['type'] == 'image' }
    images.each { |i| new_article.images.create(uri(i)) }
  end

  def types(article)
    article.fetch('types').join(', ')
  end

  def authors(article)
    article
      .fetch('authors')
      .map { |a| a['fullName'] }
      .join(', ')
  end

  # default to medium for now
  def uri(image)
    image.dig('medium, uri')
  end
end
