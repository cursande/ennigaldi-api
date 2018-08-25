# frozen_string_literal: true

module Web::Controllers::Articles
  class Fetch
    include Web::Action

    def call(params)
      # For now, will make a direct request to external endpoints,
      # rather than sending it through the worker
      fetch_total = params[:fetch_total]
      page_total = (fetch_total.to_f / params[:per_page]).ceil
      collect_articles(fetch_total, page_total)
    end

    private

    def collect_articles(fetch_total, page_total)
      current_page = 1
      total_fetched = 0

      until current_page >= page_total
        articles = service.request('/articles', current_page)
        articles.each do |article|
          break if total_fetched >= fetch_total
          ArticleRepository.new.create_with_images(article)
        end
        current_page += 1
      end
    end

    def service
      @service ||= Web::MVService.new(per_page)
    end
  end
end
