# frozen_string_literal: true

module WebMockHelpers
  SERVICES_MAP = {
    mv_search: { url: %r{https://collections.museumvictoria.com.au/api/search.*} },
    fetch_mv_articles: { url: %r{https://collections.museumvictoria.com.au/api/articles} },
    fetch_mv_image: { url: %r{https://collections.museumvictoria.com.au/content/media/.*\.jpg} }
  }.freeze

  def stub_service(service_name, status: 200, method: nil, with: {}, response_headers: {}, response_body: nil, response_fixture: nil, to_raise: nil)
    service = SERVICES_MAP.fetch(service_name)

    method ||= service.fetch(:default_method, :get)
    url = service.fetch(:url)
    response_headers = service[:default_headers] if response_headers.empty?
    response_body ||= load_fixture(response_fixture || service_name)

    stub = stub_request(method, url)
    stub.with(with) if with.any?

    if to_raise.nil?
      stub.to_return(status: status, body: response_body, headers: response_headers)
    else
      stub.to_raise(to_raise)
    end

    stub
  end

  def load_fixture(fixture_file_name)
    File.read(File.join('spec', 'web', 'fixtures', 'services', fixture_file_name.to_s))
  end
end

RSpec.configure do |config|
  config.include WebMockHelpers
end
