require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views
  let(:user) { FactoryGirl.create(:user) }
  before { login_as_user(user) }

  describe '#index' do
    before { get :index }
    it { is_expected.to render_template :index }
  end
end
