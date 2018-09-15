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

  # TODO: Pull this into a spec helper
  let(:repository) { ArticleRepository.new }
  before { stub_service(:fetch_mv_image, response_body: IO.read('spec/web/media/test_image.jpg', 1)) }
  before { repository.create_with_images(Oj.load(File.read('spec/web/fixtures/services/mv_article'))) }


  describe 'articles' do
    let(:article) { repository.last }
    let(:query_string) { %|{ articles { id title contentSummary images } }| }

    it 'returns an array of all the articles in the db with the selected fields' do
      expect(result.to_h['data']['article']['title']).to eq(article.title)
    end
  end

  describe 'article(with id provided)' do
    let(:article) { repository.last }
    let(:query_string) { %|{ article(id: #{article.id}) { title } }| }

    it 'returns the title of the article' do
      expect(result.to_h['data']['article']['title']).to eq(article.title)
    end
  end

  describe 'article(with no id provided)' do
    let(:query_string) { %({ article { title } }) }

    it 'returns an error stating that id is missing' do
      expect(result.to_h['errors'].first['message']).to include("Field 'article' is missing required arguments: id")
    end
  end
end
