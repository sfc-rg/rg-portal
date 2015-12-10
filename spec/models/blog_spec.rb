require 'rails_helper'

RSpec.describe Blog, type: :model do
  describe '#timestamp' do
    let(:blog) { FactoryGirl.create(:blog) }

    context 'when anytime' do
      subject { blog.timestamp }
      before { Timecop.freeze(2015, 10, 1, 9, 0, 0, 0) }
      after { Timecop.return }

      it 'returns its timestamp' do
        is_expected.to eq('20151001090000000000')
      end
    end
  end
end
