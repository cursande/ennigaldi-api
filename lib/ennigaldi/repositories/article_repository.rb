require 'down'

class ArticleRepository < Hanami::Repository
  associations do
    has_many :images
  end

  # Where we might want to match the whole case, and return only one result
  FINDABLE_ATTRIBUTES = %w[external_id title]

  # Where it might make more sense to pattern match, and return all results
  SEARCHABLE_ATTRIBUTES = %w[content content_summmary types authors]

  FINDABLE_ATTRIBUTES.each do |attribute|
    define_method("find_by_#{attribute}") do |value|
      articles
        .where("#{attribute}": value.to_s)
        .one
    end

    define_method("find_by_#{attribute}_with_images") do |value|
      aggregate(:images)
        .where("#{attribute}": value.to_s)
        .map_to(Article)
        .one
    end
  end

  SEARCHABLE_ATTRIBUTES.each do |attribute|
    define_method("search_by_#{attribute}") do |value|
      articles
        .where(Sequel.lit("#{attribute} ILIKE '%#{value}%'"))
        .to_a
    end

    define_method("search_by_#{attribute}_with_images") do |value|
      aggregate(:images)
        .where(Sequel.lit("#{attribute} ILIKE '%#{value}%'"))
        .map_to(Article)
        .to_a
    end
  end

  def create_with_images(article_data)
    new_article = create(attributes(article_data))
    process_images(article_data, new_article)
  end

  def all_with_images
    aggregate(:images).map_to(Article).to_a
  end

  def find_with_images(id)
    aggregate(:images).where(id: id).map_to(Article).one
  end

  private

  def attributes(article_data)
    {
      external_id: article_data.fetch('id'),
      title: article_data.fetch('title'),
      content: article_data.fetch('content'),
      content_summary: article_data.fetch('contentSummary'),
      types: types(article_data),
      authors: authors(article_data)
    }
  end

  def process_images(article_data, new_article)
    images = article_data.fetch('media').select { |m| m['type'] == 'image' }
    images.each { |i| add_image(new_article, uri(i)) }
  end

  # default to medium for now
  def uri(image)
    image.dig('medium', 'uri')
  end

  def types(article_data)
    article_data.fetch('types').join(', ')
  end

  def authors(article_data)
    article_data
      .fetch('authors')
      .map { |a| a['fullName'] }
      .join(', ')
  end

  def add_image(article, image_uri)
    uploaded_image = image_uploader.upload(Down.open(image_uri))
    assoc(:images, article).add(uri: uploaded_image.url)
  end

  def image_uploader
    @image_uploader ||= ImageUploader.new(:store)
  end
end
