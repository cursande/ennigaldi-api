# frozen_string_literal: true

module Web::Controllers::Articles
  class Fetch
    include Web::Action

    def call(params)
      # For now, will make a direct request to external endpoints, rather than sending it through the worker
      fetch_total = params[:fetch_total]
      page_total = (fetch_total.to_f / params[:per_page]).ceil
      current_page = 1
      total_fetched = 0

      until current_page >= page_total
        articles = service.request('/articles', current_page)
        articles.each do |article|
          break if total_fetched >= fetch_total
          ArticleRepository.new(attributes(article))
          process_images(article)
        end
       current_page += 1
      end
    end

    private

    def service
      @service ||= Web::MVService.new(per_page)
    end

    def attributes(article)
      {
        title: article.fetch('objectName'),
        description: article.fetch('objectSummary'),
        category: article.fetch('category'),
        significance: article.fetch('significance')
      }
    end

    def process_images(article)
      images = article.fetch('media').select { |m| m['type'] == 'image' }
      images.each { |i| ImageRepository.new(article, uri(i)) }
    end

    # default to medium for now
    def uri(image)
      image.dig('medium, uri')
    end
  end
end
