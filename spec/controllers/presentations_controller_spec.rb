require 'rails_helper'

RSpec.describe PresentationsController, type: :controller do
  render_views
  let(:user) { FactoryGirl.create(:user) }
  let(:meeting) { FactoryGirl.create(:meeting) }
  before { login_as_user(user) }

  describe '#show' do
    let(:presentation) { FactoryGirl.create(:presentation, meeting: meeting) }
    subject { get :show, id: presentation.id }
    it { is_expected.to render_template :show }
  end

  describe '#new' do
    let(:presentation) { FactoryGirl.create(:presentation, meeting: meeting) }
    subject { get :new, meeting_id: meeting.id }
    it { is_expected.to render_template :new }
  end

  describe '#create' do
    subject { post :create, meeting_id: meeting.id, presentation: FactoryGirl.attributes_for(:presentation) }
    it { is_expected.to redirect_to meeting_path(meeting) }
  end

  describe '#edit' do
    subject { get :edit, id: presentation.id }
    context 'when having an ownership' do
      let(:presentation) { FactoryGirl.create(:presentation, meeting: meeting, user: user) }
      it { is_expected.to render_template :edit }
    end

    context 'when not having an ownership' do
      let(:presentation) { FactoryGirl.create(:presentation, meeting: meeting) }
      it { is_expected.to redirect_to meeting_path(meeting) }
    end
  end

  describe '#update' do
    subject { patch :update, id: presentation.id, presentation: FactoryGirl.attributes_for(:presentation) }
    context 'when having an ownership' do
      let(:presentation) { FactoryGirl.create(:presentation, meeting: meeting, user: user) }
      it { is_expected.to redirect_to meeting_path(presentation.meeting) }
    end

    context 'when not having an ownership' do
      let(:presentation) { FactoryGirl.create(:presentation, meeting: meeting) }
      it { is_expected.to redirect_to meeting_path(meeting) }
    end
  end

  describe '#destroy' do
    subject { delete :destroy, id: presentation.id }
    context 'when having an ownership' do
      let!(:presentation) { FactoryGirl.create(:presentation, meeting: meeting, user: user) }
      it 'delete presentation' do
        expect { subject }.to change(Presentation, :count).by(-1)
      end
      it { is_expected.to redirect_to meeting_path(presentation.meeting) }
    end

    context 'when not having an ownership' do
      let!(:presentation) { FactoryGirl.create(:presentation, meeting: meeting) }
      it 'do not delete presentation' do
        expect { subject }.not_to change(Presentation, :count)
      end
      it { is_expected.to redirect_to meeting_path(meeting) }
    end
  end
end
