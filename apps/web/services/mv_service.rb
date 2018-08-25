# frozen_string_literal: true

class Web::MVService
  class ServiceError < StandardError; end

  def initialize(per_page = nil)
    @per_page &&= per_page
  end

  def request(params = '', page = nil)
    response = HTTP.get(root_uri + params + per_page + page(page))
    raise ServiceError, 'Could not fetch data from MV' unless response.code == 200
    Oj.load(response.to_s)
  end

  # TODO: should non-article items just be ignored?
  def search(queries)
    raise ServiceError, 'No search queries provided' if queries.empty?
    request('/search?' + queries.map { |query| "query=#{query}" }.join('&'))
  end

  private

  def root_uri
    @root_uri ||= 'https://collections.museumvictoria.com.au/api'
  end

  def page(page)
    page ? "&page=#{page}" : ''
  end

  def per_page
    @per_page ? "&perpage=#{@per_page}" : ''
  end
end
