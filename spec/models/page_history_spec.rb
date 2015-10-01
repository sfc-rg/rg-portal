require 'rails_helper'

RSpec.describe PageHistory, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:page) { FactoryGirl.create(:page, user: user) }
  let(:page_history) { FactoryGirl.create(:page_history, page: page, user: user) }

  describe '#content' do
    subject { page_history.content }

    context 'when first history' do
      it 'returns page content' do
        is_expected.to eq(page.content)
      end
    end
  end

  describe '#previous' do
    let!(:current) { FactoryGirl.create(:page_history, id: page_history.id + 10, page: page, user: user) }
    let!(:previous) { FactoryGirl.create(:page_history, id: current.id - 1, page: page, user: user) }
    subject { current.previous }

    it { is_expected.to eq(previous) }
  end
end
