RSpec.describe ArticleRepository, type: :repository do
  subject { described_class.new }

  describe '#create_with_images' do
    let(:article_data) { Oj.load(File.read('spec/web/fixtures/services/mv_article')) }

    it 'saves an article and its associated images in the db' do
      subject.create_with_images(article_data)

      article_repository = ArticleRepository.new
      image_repository = ImageRepository.new

      expect(article_repository.all.length).to eql(1)
      expect(image_repository.all.length).to eql(1)

      article = article_repository.last

      expect(article.title).to eql('some string')
      expect(article.authors).to eql('Nina something something')
    end
  end
end
