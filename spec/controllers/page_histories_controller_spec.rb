require 'rails_helper'

RSpec.describe PageHistoriesController, type: :controller do
  render_views
  let(:user) { FactoryGirl.create(:user, ldap_credential: nil) }
  let(:page) { FactoryGirl.create(:page, user: user) }
  let(:page_history) { FactoryGirl.create(:page_history, page: page, user: user) }
  before { session[:user_id] = user.id }

  describe '#index' do
    before do
      get :index, path: page.path
    end

    it 'renders index action' do
      expect(response).to render_template(:index)
    end
  end

  describe '#show' do
    context 'when exists page history' do
      before do
        get :show, path: page.path, id: page_history.id
      end

      it 'renders show action' do
        expect(response).to render_template(:show)
      end
    end

    context 'when not exists page history' do
      before do
        page_history.destroy!
        get :show, path: page.path, id: page_history.id
      end

      it 'redirects page histories' do
        expect(response).to redirect_to(:page_histories)
      end
    end
  end

  describe '#diff' do
    before do
      get :diff, path: page.path, id: page_history.id
    end

    it 'renders diff action' do
      expect(response).to render_template(:diff)
    end
  end
end
