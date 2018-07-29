# frozen_string_literal: true

module Web::Controllers::Articles
  class Fetch
    include Web::Action

    # hardcoded for now, these values will eventually be set in workers or set by user via front end
    FETCH_TOTAL = 60
    PER_PAGE = 20

    def call(params)
      # For now, will make a direct request to external endpoints, rather than sending it through the worker
      # Will save to a common article repository with titles, descriptions, images etc.
      page_total = (FETCH_TOTAL.to_f / PER_PAGE).ceil
      current_page = 1

      until current_page == page_total
        articles = service(current_page).request('/articles')
        += current_page
      end
    end


    private

    def service
    end
  end
end
