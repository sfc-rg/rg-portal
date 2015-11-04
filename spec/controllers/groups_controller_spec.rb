require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  render_views
  before { login_as_user }

  describe '#index' do
    before do
      get :index
    end

    it 'renders index action' do
      expect(response).to render_template(:index)
    end
  end
end
