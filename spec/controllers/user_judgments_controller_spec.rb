require 'rails_helper'

RSpec.describe UserJudgmentsController, type: :controller do
  render_views
  let(:user) { FactoryGirl.create(:user) }
  let(:presentation) { FactoryGirl.create(:presentation) }
  before { login_as_user(user) }

  describe '#index' do
    before { get :index, presentation_id: presentation.id }
    it { is_expected.to render_template(:index) }
  end

  describe '#create' do
    subject do
      post :create, format: :js, presentation_id: presentation.id,
           user_judgment: FactoryGirl.attributes_for(:user_judgment)
    end
    it { is_expected.to render_template :create }
  end

  describe '#destroy' do
    subject { delete :destroy, format: :js, id: user_judgment.id }

    context 'when having an ownership' do
      let!(:user_judgment) { FactoryGirl.create(:user_judgment, presentation: presentation, user: user) }
      it 'delete user judgment' do
        expect { subject }.to change(UserJudgment, :count).by(-1)
      end
      it { is_expected.to render_template :create }
    end

    context 'when not having an ownership' do
      let!(:user_judgment) { FactoryGirl.create(:user_judgment, presentation: presentation) }
      it 'do not delete user judgment' do
        expect { subject }.not_to change(UserJudgment, :count)
      end
      it { is_expected.to be_forbidden }
    end
  end
end
