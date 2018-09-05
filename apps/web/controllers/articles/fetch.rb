# frozen_string_literal: true

module Web::Controllers::Articles
  class Fetch
    include Web::Action

    def call(params)
      # For now, will make a direct request to external endpoints,
      # rather than sending it through the worker. Eventually we'll want
      # to split pages up between threads.
      fetch_total = params[:fetch_total]
      per_page = ENV['ITEMS_PER_PAGE']
      page_total = (fetch_total.to_f / per_page.to_i).ceil if per_page
      collect_articles(fetch_total, page_total)
    end

    private

    def collect_articles(fetch_total, page_total)
      current_page = 1
      total_fetched = 0

      while current_page <= page_total
        articles = service.request('/articles', current_page)
        articles.each do |article|
          break if total_fetched >= fetch_total
          repository.create_with_images(article)
          total_fetched += 1
        end
        current_page += 1
      end
    end

    def service
      @service ||= Web::MVService.new
    end

    def repository
      @repository ||= ArticleRepository.new
    end
  end
end
