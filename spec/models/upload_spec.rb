require 'rails_helper'

RSpec.describe Upload, type: :model do
  describe '#image?' do
    let(:upload) { FactoryGirl.create(:upload, content_type: content_type) }
    subject { upload.image? }

    context 'when include image' do
      let(:content_type) { 'image/jpeg' }
      it { is_expected.to be_truthy }
    end

    context 'when not include image' do
      let(:content_type) { 'application/pdf' }
      it { is_expected.to be_falsey }
    end
  end
end
