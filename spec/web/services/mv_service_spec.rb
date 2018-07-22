# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Web::MVService do
  subject { described_class.new }

  describe '#search' do
    context 'with multiple queries' do
      let(:queries) { %w[shoe soldier] }

      it 'returns a parsed response after making a request to MV with queries as parameters' do
        stub_service(:mv_search)
        response = subject.search(queries)

        expect(response.first.fetch('recordType')).to eql('item')
        expect(response.first.fetch('category')).to eql('History & Technology')
        expect(response.first.fetch('acquisitionInformation')).to eql('Donation from J. Lord, 24 Feb 1986')
      end
    end

    context 'with no queries' do
    end
  end
end
