RSpec.describe Schema do
  # You can override `context` or `variables` in
  # more specific scopes
  let(:context) { {} }
  let(:variables) { {} }
  # Call `result` to execute the query
  let(:result) {
    res = Schema.execute(
      query_string,
      context: context,
      variables: variables
    )
    # Print any errors
    if res["errors"]
      pp res
    end
    res
  }

  before { stub_service(:fetch_mv_image, response_body: IO.read('spec/web/media/test_image.jpg', 1)) }

  describe "a specific query" do
    let!(:article) { ArticleRepository.new.create_with_images(Oj.load(File.read('spec/web/fixtures/services/mv_article'))) }

    let(:query_string) { %|{ article { title } }| }
    it "returns the article title" do
      expect(result.to_h['data'].first['article']['title']).to eq(article.title)
    end
  end
end
