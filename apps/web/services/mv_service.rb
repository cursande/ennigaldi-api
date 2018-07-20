module MVService
  class Article
    def initialize(per_page)
      @per_page = per_page
    end

    def root_uri
      @root_uri ||= "https://collections.museumvictoria.com.au/api"
    end

    def search(queries)
      queries.map { |query| "query=#{query.to_s}" }.join('&')
    end
  end
end
