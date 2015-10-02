require 'rails_helper'

describe Page, type: :model do
  let(:page) { FactoryGirl.create(:page, path: 'A', content: 'A') }
  it_behaves_like 'emojifier'

  describe '#renamed?' do
    subject { page.send(:renamed?) }

    context 'when not rename' do
      it 'returns false' do
        is_expected.to be_falsey
      end
    end

    context 'when rename' do
      before { page.path = 'B' }

      it 'returns true' do
        is_expected.to be_truthy
      end
    end
  end

  describe '#create_renamed_page' do
    context 'when rename' do
      subject { page.send(:create_renamed_page).before_path }
      before { page.path = 'B' }

      it 'creates renamed page model with before_path' do
        is_expected.to eq('A')
      end
    end
  end

  describe '#create_page_history' do
    context 'when content change' do
      subject { page.send(:create_page_history).content }
      before { page.content = 'B' }

      it 'creates page history with content' do
        is_expected.to eq('B')
      end
    end
  end
end
