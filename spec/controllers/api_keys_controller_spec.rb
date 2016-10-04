require 'rails_helper'

RSpec.describe ApiKeysController, type: :controller do
  render_views
  let(:user) { FactoryGirl.create(:user) }
  before { login_as_user(user) }

  describe '#index' do
    subject { get :index }
    it { is_expected.to render_template :index }
  end

  describe '#create' do
    subject { post :create }

    context 'with privilege' do
      before { FactoryGirl.create(:privilege, user: user, model: 'api_keys', action: 'create') }
      it { is_expected.to redirect_to api_keys_path }

      it 'creates the new api key' do
        expect{ subject }.to change{ ApiKey.count }.by(1)
      end
    end

    context 'without privilege' do
      it { is_expected.to be_forbidden }

      it 'does not create any api keys' do
        expect{ subject }.to change{ ApiKey.count }.by(0)
      end
    end
  end

  describe '#destroy' do
    let(:api_key_owner) { FactoryGirl.create(:user) }
    let(:api_key) { FactoryGirl.create(:api_key, user: api_key_owner) }
    subject { delete :destroy, id: api_key.id }

    context 'with privilege' do
      before { FactoryGirl.create(:privilege, user: user, model: 'api_keys', action: 'destroy') }
      it { is_expected.to redirect_to api_keys_path }

      it 'revokes the api key' do
        expect { subject }.to change{ api_key.reload.revoked? }.from(false).to(true)
      end
    end

    context 'without privilege but api key owner' do
      let(:api_key_owner) { user }

      it { is_expected.to redirect_to api_keys_path }

      it 'revokes the api key' do
        expect { subject }.to change{ api_key.reload.revoked? }.from(false).to(true)
      end
    end

    context 'without privilege' do
      it { is_expected.to be_forbidden }

      it 'does not revoke the api key' do
        expect { subject }.to_not change{ api_key.reload.revoked? }
      end
    end
  end
end
