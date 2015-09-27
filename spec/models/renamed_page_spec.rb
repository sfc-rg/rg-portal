require 'rails_helper'

RSpec.describe RenamedPage, type: :model do
  describe '.find_page' do
    let(:original_path) { 'original' }
    subject { RenamedPage.find_page(original_path) }

    context 'when not rename' do
      let!(:page) { FactoryGirl.create(:page, path: original_path) }
      it 'returns nil' do
        is_expected.to be_nil
      end
    end

    context 'when rename once' do
      let!(:page) { FactoryGirl.create(:page, path: 'first') }
      let!(:first_rename) { FactoryGirl.create(:renamed_page, before_path: original_path, after_path: 'first') }
      it 'returns first renamed after_path' do
        is_expected.to eq(page)
      end
    end

    context 'when rename twice' do
      let!(:page) { FactoryGirl.create(:page, path: 'second') }
      let!(:first_rename) { FactoryGirl.create(:renamed_page, before_path: original_path, after_path: 'first') }
      let!(:second_rename) { FactoryGirl.create(:renamed_page, before_path: 'first', after_path: 'second') }
      it 'returns second renamed after_path' do
        is_expected.to eq(page)
      end
    end
  end
end
