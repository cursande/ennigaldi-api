require "down"

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

  # default to medium for now
  def uri(image)
    image.dig('medium', 'uri')
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

  def add_image(article, image_uri)
    uploaded_image = image_uploader.upload(Down.open(image_uri))
    assoc(:images, article).add(uri: uploaded_image.url, image_data: uploaded_image)
  end

  def image_uploader
    @image_uploader ||= ImageUploader.new(:store)
  end
end
