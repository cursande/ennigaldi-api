# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Web::MVService do
  subject { described_class.new }

  describe '#search' do
    context 'with multiple queries' do
      context 'with no page or page limit provided' do
        let(:queries) { %w[shoe soldier] }

        it 'returns a parsed response after making a request to MV with queries as parameters' do
          stub_service(:mv_search)
          response = subject.search(queries)

          expect(response.first.fetch('recordType')).to eql('item')
          expect(response.first.fetch('category')).to eql('History & Technology')
          expect(response.first.fetch('acquisitionInformation')).to eql('Donation from J. Lord, 24 Feb 1986')
        end
      end
    end

    context 'with no queries' do
      let(:queries) { [] }

      it 'raises a service error, as no queries have been provided' do
        expect{ subject.search(queries) }.to raise_error(Web::MVService::ServiceError, 'No search queries provided')
      end
    end
  end
end
