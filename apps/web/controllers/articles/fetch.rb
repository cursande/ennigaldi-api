# frozen_string_literal: true

module Web::Controllers::Articles
  class Fetch
    include Web::Action

    def call(params)
      # fetch_total will only be an approximate of what we fetch,
      # since we just use the value to determine how many pages
      # we grab
      fetch_total = params[:fetch_total]
      per_page = ENV.fetch('ITEMS_PER_PAGE')
      page_total = (fetch_total.to_f / per_page.to_i).ceil

      FetchWorker.new.perform(page_total)
    end
  end
end
