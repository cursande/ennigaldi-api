RSpec.describe ArticleRepository, type: :repository do
  subject { described_class.new }

  describe '#create_with_images' do
    let(:article_data) { Oj.load(File.read('spec/web/fixtures/services/mv_article')) }
    let(:article_repository) { ArticleRepository.new }
    let(:image_repository) { ImageRepository.new }

    before do
      article_repository.clear
      image_repository.clear
    end

    it 'saves an article and its associated images in the db' do
      stub_service(
        :fetch_mv_image,
        response_body: IO.read('spec/web/media/test_image.jpg', 1)
      )

      subject.create_with_images(article_data)

      expect(article_repository.all.length).to eql(1)
      expect(image_repository.all.length).to eql(1)

      article = article_repository.find_with_images(article_repository.last.id)

      expect(article.title).to eql('The Battle of the Somme, 1916')
      expect(article.authors).to eql('Nina K. Buchan')
      expect(article.images.last.uri).to include('memory://')
    end
  end
end
