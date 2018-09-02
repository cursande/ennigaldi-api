RSpec.describe Web::Controllers::Articles::Fetch, type: :action do
  let(:action) { described_class.new }
  let(:article_repository) { ArticleRepository.new }
  let(:image_repository) { ImageRepository.new }
  let(:params) { fetch_total: 10 }

  describe '#call' do
    context 'with a page of articles' do
      before { stub_service(:fetch_mv_articles) }
      it 'saves the specified number of articles' do
        action.call(params)

        articles = article_repository.all
        expect(articles.count).to eql(3)
      end
    end
  end
end
