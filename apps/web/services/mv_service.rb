# frozen_string_literal: true

class Web::MVService
  class ServiceError < StandardError; end

  ROOT_URI = 'https://collections.museumvictoria.com.au/api'

  def initialize
    @per_page = ENV['ITEMS_PER_PAGE']
  end

  def request(params = '', page = nil)
    response = HTTP.get(ROOT_URI + params + per_page + page(page))
    raise ServiceError, 'Could not fetch data from MV' unless response.code == 200
    Oj.load(response.to_s)
  end

  # TODO: should non-article items just be ignored?
  def search(queries)
    raise ServiceError, 'No search queries provided' if queries.empty?
    request('/search?' + queries.map { |query| "query=#{query}" }.join('&'))
  end

  private

  def page(page)
    page ? "&page=#{page}" : ''
  end

  def per_page
    @per_page ? "&perpage=#{@per_page}" : ''
  end
end
