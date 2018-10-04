# frozen_string_literal: true

class Web::MVService
  class ServiceError < StandardError; end

  ROOT_URI = 'https://collections.museumvictoria.com.au/api'

  def initialize
    @per_page = ENV.fetch('ITEMS_PER_PAGE')
  end

  def request(endpoint = '', page = nil)
    response = HTTP.get(ROOT_URI + endpoint, params: { per_page: @per_page, page: page }.compact)
    raise ServiceError, 'Could not fetch data from MV' unless response.code == 200
    Oj.load(response.to_s)
  end

  def search(queries)
    raise ServiceError, 'No search queries provided' if queries.empty?
    request('/search?' + queries.map { |query| "query=#{query}" }.join('&'))
  end
end
