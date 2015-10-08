require 'rails_helper'

RSpec.describe PagesHelper, type: :helper do
  describe '#page_breadcrumb_links' do
    let(:page) { FactoryGirl.create(:page) }
    let(:paths) { ['A'] }
    subject { helper.page_breadcrumb_links(page) }
    before do
      allow(page).to receive(:paths).and_return(paths)
    end

    context 'when have one child' do
      it 'includes one child' do
        is_expected.to include('A')
      end
    end
  end
end
