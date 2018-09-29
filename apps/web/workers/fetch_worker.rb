class FetchWorker
  include Sidekiq::Worker

  def perform(page_total)
    # Only one service for now
    (1..page_total).each { |page| FetchFromMVWorker.perform_async(page) }
  end
end
