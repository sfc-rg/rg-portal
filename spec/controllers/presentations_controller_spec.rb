require 'rails_helper'

RSpec.describe PresentationsController, type: :controller do
  render_views
  let(:user) { FactoryGirl.create(:user) }
  before { login_as_user(user) }

  describe '#show' do
    let(:meeting) { FactoryGirl.create(:meeting) }
    let(:presentation) { FactoryGirl.create(:presentation, meeting: meeting) }
    subject { get :show, id: presentation.id }
    it { is_expected.to render_template :show }
  end

  describe '#new' do
    let(:presentation) { FactoryGirl.create(:presentation, meeting: meeting) }
    subject { get :new, meeting_id: meeting.id }

    context 'when accepting' do
      let(:meeting) { FactoryGirl.create(:meeting) }
      it { is_expected.to render_template :new }
    end

    context 'when not accepting' do
      let(:meeting) { FactoryGirl.create(:meeting, accepting: false) }
      it { is_expected.to redirect_to meeting_path(meeting) }
    end
  end

  describe '#create' do
    subject { post :create, meeting_id: meeting.id, presentation: FactoryGirl.attributes_for(:presentation) }

    context 'when accepting' do
      let(:meeting) { FactoryGirl.create(:meeting) }
      it 'create a presentation' do
        expect { subject }.to change(Presentation, :count).by(1)
      end
      it { is_expected.to redirect_to meeting_path(meeting) }
    end

    context 'when not accepting' do
      let(:meeting) { FactoryGirl.create(:meeting, accepting: false) }
      it 'do not create a presentation' do
        expect { subject }.to change(Presentation, :count).by(0)
      end
      it { is_expected.to redirect_to meeting_path(meeting) }
    end
  end

  describe '#edit' do
    let(:meeting) { FactoryGirl.create(:meeting) }
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
    let(:meeting) { FactoryGirl.create(:meeting) }
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
    let(:meeting) { FactoryGirl.create(:meeting) }
    subject { delete :destroy, id: presentation.id }
    context 'when having an ownership' do
      let!(:presentation) { FactoryGirl.create(:presentation, meeting: meeting, user: user) }
      it 'delete the presentation' do
        expect { subject }.to change(Presentation, :count).by(-1)
      end
      it { is_expected.to redirect_to meeting_path(presentation.meeting) }
    end

    context 'when not having an ownership' do
      let!(:presentation) { FactoryGirl.create(:presentation, meeting: meeting) }
      it 'do not delete the presentation' do
        expect { subject }.not_to change(Presentation, :count)
      end
      it { is_expected.to redirect_to meeting_path(meeting) }
    end
  end
end
