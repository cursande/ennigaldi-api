RSpec.describe Web::Controllers::Articles::Fetch, type: :action do
  let(:action) { described_class.new }
  let(:article_repository) { ArticleRepository.new }
  let(:image_repository) { ImageRepository.new }
  let(:params) { Hash[fetch_total: 10] }

  before do
    article_repository.clear
    image_repository.clear
  end

  describe '#call' do
    context 'with a page of articles' do
      before do
        stub_service(:fetch_mv_articles)
        stub_service(
          :fetch_mv_image,
          response_body: IO.read('spec/web/media/test_image.jpg', 1)
        )
      end

      it 'saves the specified number of articles' do
        action.call(params)

        articles = article_repository.all
        expect(articles.count).to eql(3)
      end
    end
  end
end
