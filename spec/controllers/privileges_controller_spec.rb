require 'rails_helper'

RSpec.describe PrivilegesController, type: :controller do
  render_views
  let(:user) { FactoryGirl.create(:user) }
  before { login_as_user(user) }

  describe '#new' do
    subject { get :new }
    it { is_expected.to render_template :new }
  end

  describe '#create' do
    let(:target_user) { FactoryGirl.create(:user) }
    let(:attributes) { FactoryGirl.attributes_for(:privilege).merge(user_id: target_user.id) }
    subject { post :create, privilege: attributes }

    context 'with privilege' do
      before { FactoryGirl.create(:privilege, user: user, model: attributes[:model], action: attributes[:action]) }
      it 'create privilege' do
        expect { subject }.to change(Privilege, :count).by(1)
      end
      it { is_expected.to render_template :new }
    end

    context 'without privilege' do
      it 'do not create privilege' do
        expect { subject }.not_to change(Presentation, :count)
      end
      it { is_expected.to render_template :new }
    end
  end
end
