require 'rails_helper'

RSpec.describe PreBuiltPagesController, type: :controller do
  render_views
  let(:user) { FactoryGirl.create(:user) }
  before { session[:user_id] = user.id }

  describe '#wip_term' do
    before do
      get :wip_term
    end

    it 'renders wip_term action' do
      expect(response).to render_template(:wip_term)
    end
  end

  describe '#thesis' do
    before do
      get :thesis
    end

    it 'renders thesis action' do
      expect(response).to render_template(:thesis)
    end
  end

  describe '#newcomer' do
    before do
      get :newcomer
    end

    it 'renders newcomer action' do
      expect(response).to render_template(:newcomer)
    end
  end
end
