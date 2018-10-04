require 'sidekiq/testing'

RSpec.describe Web::Controllers::Articles::Fetch, type: :action do
  let(:action) { described_class.new }
  let(:repository) { ArticleRepository.new }
  let(:params) { Hash[fetch_total: 10] }

  describe '#call' do
    before do
      stub_service(:fetch_mv_articles)
      stub_service(
        :fetch_mv_image,
        response_body: IO.read('spec/web/media/test_image.jpg', 1)
      )
    end

    it 'saves articles from a preset number of pages' do
      Sidekiq::Testing.inline! do
        action.call(params)
      end

      articles = repository.all
      expect(articles.count).to eql(3)
    end
  end
end
