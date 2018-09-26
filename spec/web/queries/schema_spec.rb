RSpec.describe EnnigaldiSchema do
  let(:context) { {} }
  let(:variables) { {} }
  let(:result) {
    res = EnnigaldiSchema.execute(
      query_string,
      context: context,
      variables: variables
    )
    pp res if res['errors']
    res
  }

  let(:repository) { ArticleRepository.new }

  before do
    stub_service(:fetch_mv_image, response_body: IO.read('spec/web/media/test_image.jpg', 1))
    repository.create_with_images(Oj.load(File.read('spec/web/fixtures/services/mv_article')))
  end

  let(:article) { repository.last }
  let(:images) { repository.find_with_images(article.id).images }

  describe 'articles' do
    let(:query_string) { %|{ articles { id title contentSummary images { uri } } }| }

    it 'returns an array of all the articles in the db with the selected fields and associated images' do
      expect(result.to_h['data']['articles'].length).to eq(1)
      expect(result.to_h['data']['articles'].first['contentSummary']).to eq(article.content_summary)
      expect(result.to_h['data']['articles'].first['images'].first['uri']).to eq(images.first.uri)
    end
  end

  describe 'article(with id provided)' do
    let(:query_string) { %|{ article(id: #{article.id}) { title images { uri } } }| }

    it 'returns the title and associated images for the article' do
      expect(result.to_h['data']['article']['title']).to eq(article.title)
      expect(result.to_h['data']['article']['images'].first['uri']).to eq(images.first.uri)
    end
  end
end
