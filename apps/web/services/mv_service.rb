# frozen_string_literal: true

class Web::MVService
  class ServiceError < StandardError; end
  attr_reader :page

  def initialize(page = 1, per_page = nil)
    @page = page
    @per_page &&= per_page
  end

  def request(params)
    response = HTTP.get(root_uri + per_page + page + params)
    raise ServiceError unless response.code == 200
    Oj.load(response.to_s)
  end

  def search(queries)
    request('/search?' + queries.map { |query| "query=#{query}" }.join('&'))
  end

  private

  def root_uri
    @root_uri ||= 'https://collections.museumvictoria.com.au/api'
  end

  def page
    "&page=#{page}"
  end

  def per_page
    @per_page ? "&perpage=#{@per_page}" : ''
  end
end
