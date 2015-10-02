require 'rails_helper'

RSpec.describe PreBuiltPagesHelper, type: :helper do
  describe '#include_page_content' do
    let(:page) { FactoryGirl.create(:page) }
    let(:default) { nil }
    subject { helper.include_page_content(page.path, default) }

    context 'when given exists page path' do
      it 'returns rendered content' do
        is_expected.to eq(page.render_content)
      end
    end

    context 'when given not exists page path' do
      before { page.destroy }

      it 'returns default' do
        is_expected.to eq(default)
      end
    end
  end

  describe '#include_or_create_page_content' do
    let(:page) { FactoryGirl.create(:page) }
    let(:message) { 'message' }
    subject { helper.include_or_create_page_content(page.path, message) }

    context 'when given exists page path' do
      it 'returns rendered content' do
        is_expected.to eq(page.render_content)
      end
    end

    context 'when given not exists page path' do
      before { page.destroy }

      it 'returns include message' do
        is_expected.to include(message)
      end
    end
  end

  describe '#term_name' do
    subject { helper.term_name }

    context 'when 2015-02-28' do
      before { Timecop.travel(2015, 2, 28) }
      it { is_expected.to eq('2014f') }
    end
    context 'when 2015-03-01' do
      before { Timecop.travel(2015, 3, 1) }
      it { is_expected.to eq('2015s') }
    end
    context 'when 2015-08-31' do
      before { Timecop.travel(2015, 8, 31) }
      it { is_expected.to eq('2015s') }
    end
    context 'when 2015-09-01' do
      before { Timecop.travel(2015, 9, 1) }
      it { is_expected.to eq('2015f') }
    end
  end
end
