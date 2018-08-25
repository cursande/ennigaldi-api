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
      title: article.fetch('objectName'),
      description: article.fetch('objectSummary'),
      category: article.fetch('category'),
      significance: article.fetch('significance')
    }
  end

  def process_images(article, new_article)
    images = article.fetch('media').select { |m| m['type'] == 'image' }
    images.each { |i| ImageRepository.new.create(new_article.id, uri(i)) }
  end

  # default to medium for now
  def uri(image)
    image.dig('medium, uri')
  end
end
