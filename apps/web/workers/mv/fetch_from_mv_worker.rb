class FetchFromMVWorker
  include Sidekiq::Worker

  # TODO: is there a way to order the response so we can process
  # only new articles?
  def perform(page)
    articles = service.request('/articles', page)
    articles.each do |article_data|
      next if repository.find_by_external_id(article_data.fetch('id'))
      repository.create_with_images(article_data)
    end
  end

  def service
    @service ||= Web::MVService.new
  end

  def repository
    @repository ||= ArticleRepository.new
  end
end
