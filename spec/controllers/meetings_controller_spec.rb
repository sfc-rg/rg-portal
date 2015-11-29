require 'rails_helper'

RSpec.describe MeetingsController, type: :controller do
  render_views
  let(:meeting) { FactoryGirl.create(:meeting) }
  before { login_as_user }

  describe '#index' do
    subject { get :index }
    it { is_expected.to render_template :index }
  end

  describe '#show' do
    subject { get :show, id: meeting.id }
    it { is_expected.to render_template :show }
  end

  describe '#new' do
    subject { get :new }
    it { is_expected.to render_template :new }
  end

  describe '#create' do
    subject { post :create, meeting: FactoryGirl.attributes_for(:meeting) }
    it { is_expected.to redirect_to meetings_path }
  end

  describe '#edit' do
    subject { get :edit, id: meeting.id }
    it { is_expected.to render_template :edit }
  end

  describe '#update' do
    subject { patch :update, id: meeting.id, meeting: FactoryGirl.attributes_for(:meeting) }
    it { is_expected.to redirect_to meeting_path(meeting) }
  end
end
