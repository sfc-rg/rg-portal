require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views
  let(:user) { FactoryGirl.create(:user, role: role) }
  let(:role) { :admin }

  describe '#index' do
    before do
      session[:user_id] = user.id # logged in
      get :index
    end

    context 'when access with admin user' do
      it 'renders index page' do
        expect(response).to render_template(:index)
      end
    end
    context 'when access with general user' do
      let(:role) { :general }
      it 'redirects root page' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe '#update' do
    let(:another_user) { FactoryGirl.create(:user, role: :general, ldap_credential: nil, slack_credential: nil) }
    before do
      session[:user_id] = user.id # logged in
      patch :update, id: another_user.id, user: { role: :admin }
      another_user.reload
    end

    context 'when change' do
      it 'changes another user role to admin' do
        expect(another_user.role.to_sym).to eq(:admin)
      end
    end
  end
end
