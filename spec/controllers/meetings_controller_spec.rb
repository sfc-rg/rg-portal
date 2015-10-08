require 'rails_helper'

RSpec.describe MeetingsController, type: :controller do
  render_views
  let(:user) { FactoryGirl.create(:user) }
  before { session[:user_id] = user.id }

  describe '#index' do
    before do
      get :index
    end

    it 'renders index action' do
      expect(response).to render_template(:index)
    end
  end
end
