require 'rails_helper'

RSpec.describe UserJudgementsController, type: :controller do
  render_views
  let(:user) { FactoryGirl.create(:user) }
  let(:meeting) { FactoryGirl.create(:meeting) }
  let(:presentation) { FactoryGirl.create(:presentation) }
  before { login_as_user(user) }

  describe '#index' do
    subject { get :index, meeting_id: meeting.id }

    context 'with privilege' do
      before { FactoryGirl.create(:privilege, user: user, model: 'user_judgements', action: 'index') }
      it { is_expected.to render_template :index }
    end

    context 'without privilege' do
      it { is_expected.to be_forbidden }
    end
  end

  describe '#create' do
    subject do
      post :create,
           format: :js,
           presentation_id: presentation.id,
           user_judgement: FactoryGirl.attributes_for(:user_judgement)
    end
    it { is_expected.to render_template :create }
  end

  describe '#destroy' do
    subject { delete :destroy, format: :js, id: user_judgement.id }

    context 'when having an ownership' do
      let!(:user_judgement) { FactoryGirl.create(:user_judgement, presentation: presentation, user: user) }
      it 'delete user judgement' do
        expect { subject }.to change(UserJudgement, :count).by(-1)
      end
      it { is_expected.to render_template :create }
    end

    context 'when not having an ownership' do
      let!(:user_judgement) { FactoryGirl.create(:user_judgement, presentation: presentation) }
      it 'do not delete user judgement' do
        expect { subject }.not_to change(UserJudgement, :count)
      end
      it { is_expected.to be_forbidden }
    end
  end
end
