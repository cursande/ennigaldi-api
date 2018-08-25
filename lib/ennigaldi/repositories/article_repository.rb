class ArticleRepository < Hanami::Repository
  associations do
    has_many :images
  end

  def create_with_images(article)
    new_article = create(attributes(article))
    process_images(article, new_article)
  end

  def find_with_images(id)
    aggregate(:images).where(id: id).map_to(Article).one
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
    images.each { |i| add_image(new_article, uri(i)) }
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

  # TODO: For now it saves the url from the source, but in future it should
  # be saving the url for the image on S3
  def add_image(article, image_uri)
    assoc(:images, article).add(uri: image_uri)
  end

  # default to medium for now
  def uri(image)
    image.dig('medium', 'uri')
  end
end
