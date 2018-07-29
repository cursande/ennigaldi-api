RSpec.describe Web::Controllers::Articles::Fetch, type: :action do
  let(:action) { described_class.new }
  let(:params) do
    {
      fetch_total: 60,
      per_page: 20
    }
  end

  describe '#call' do
    context 'with a page of articles' do

      it 'saves the specified number of articles' do

      end
    end
  end
end
