require 'rails_helper'

RSpec.describe BlogsController, type: :controller do
  render_views
  let(:blog) { FactoryGirl.create(:blog) }
  let(:user) { blog.user }
  before { login_as_user(user) }

  describe '#index' do
    before { get :index, nickname: user.nickname }

    it 'renders index page' do
      expect(response).to be_success
      expect(response).to render_template(:index)
    end
  end

  describe '#new' do
    before { get :new }

    it 'renders new page' do
      expect(response).to be_success
      expect(response).to render_template(:new)
    end
  end

  describe '#create' do
    before { post :create, blog: blog_params }

    context 'when given valid params' do
      let(:blog_params) { FactoryGirl.attributes_for(:blog) }
      let(:last_blog) { Blog.last }

      it 'redirects to blog show page' do
        expect(response).to be_redirect
        expect(response).to redirect_to(blog_url(last_blog.to_param))
      end
    end

    context 'when given invalid params' do
      let(:blog_params) { FactoryGirl.attributes_for(:blog, title: '') }

      it 'renders new page with content' do
        expect(response).to be_success
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#show' do
    before { get :show, blog.to_param }

    it 'renders show page' do
      expect(response).to be_success
      expect(response).to render_template(:show)
    end
  end

  describe '#update' do
    let(:blog_params) { FactoryGirl.attributes_for(:blog) }

    context 'when logined author user' do
      before { patch :update, blog.to_param.merge(blog: blog_params) }

      context 'when given valid params' do
        it 'redirects to blog show page' do
          expect(response).to be_redirect
          expect(response).to redirect_to(blog_url(blog.to_param))
        end
      end

      context 'when given invalid params' do
        let(:blog_params) { FactoryGirl.attributes_for(:blog, title: '') }

        it 'renders edit page with content' do
          expect(response).to be_success
          expect(response).to render_template(:edit)
        end
      end
    end

    context 'when logined another user' do
      before { login_as_user(another_user) }
      before { patch :update, blog.to_param.merge(blog: blog_params) }
      let(:another_user) { FactoryGirl.create(:user) }

      it 'redirect to root path' do
        expect(response).to be_redirect
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe '#edit' do
    before { get :edit, blog.to_param }

    it 'renders edit page' do
      expect(response).to be_success
      expect(response).to render_template(:edit)
    end
  end
end
