require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  render_views
  let(:user) { FactoryGirl.create(:user) }
  let(:page) { FactoryGirl.create(:page, user: user) }
  before { session[:user_id] = user.id }

  describe '#index' do
    before do
      get :index
    end

    it 'renders index action' do
      expect(response).to render_template(:index)
    end
  end

  describe '#show' do
    before do
      get :show, path: page.path
    end

    it 'renders show action' do
      expect(response).to render_template(:show)
    end
  end

  describe '#edit' do
    before do
      get :edit, path: page.path
    end

    it 'renders edit action' do
      expect(response).to render_template(:edit)
    end
  end

  describe '#update' do
    context 'when given new page params' do
      let(:page_params) { FactoryGirl.attributes_for(:page) }
      before do
        patch :update, path: page.path, page: page_params
      end

      it 'redirects show path' do
        expect(response).to redirect_to(:page)
      end

      it 'creates page' do
        page = Page.find_by(path: page_params[:path])
        expect(page.new_record?).to be_falsey
      end
    end

    context 'when given created page params' do
      let(:page) { FactoryGirl.create(:page, user: user) }
      let(:page_params) { FactoryGirl.attributes_for(:page) }
      before do
        patch :update, path: page.path, page: page_params
        page.reload
      end

      it 'redirects show path' do
        expect(response).to redirect_to(:page)
      end
    end
  end

  describe '#rename' do
    before do
      get :rename, path: page.path
    end

    it 'renders rename action' do
      expect(response).to render_template(:rename)
    end
  end
end
