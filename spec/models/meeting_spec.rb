require 'rails_helper'

RSpec.describe Meeting, type: :model do
  let(:meeting) { FactoryGirl.create(:meeting) }

  describe '.current' do
    let!(:meeting) { FactoryGirl.create(:meeting, start_at: start_at, end_at: end_at) }
    let(:start_at) { DateTime.new(2015, 9, 1) }
    let(:end_at) { DateTime.new(2015, 11, 1) }
    before { Timecop.travel(2015, 10, 1) }
    after { Timecop.return }
    subject { Meeting.current }

    context 'when meeting held now' do
      it { is_expected.to eq(meeting) }
    end

    context 'when meeting held in future' do
      let(:start_at) { DateTime.new(2015, 10, 2) }
      it { is_expected.to be_nil }
    end

    context 'when meeting held in past' do
      let(:end_at) { DateTime.new(2015, 9, 30) }
      it { is_expected.to be_nil }
    end
  end
end
