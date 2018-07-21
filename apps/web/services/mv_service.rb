class Web::MVService
  class ServiceError < StandardError; end

  def initialize(per_page = nil)
    @per_page &&= per_page
  end

  def request(params)
    response = HTTP.get(root_uri + per_page + params)
    raise ServiceError unless response.code == 200
    Oj.load(response.to_s)
  end

  def search(queries)
    request("/search?" + queries.map { |query| "query=#{query}" }.join('&'))
  end

  private

  def root_uri
    @root_uri ||= 'https://collections.museumvictoria.com.au/api'
  end

  def per_page
    @per_page ? "&perpage=#{@per_page}" : ''
  end
end
