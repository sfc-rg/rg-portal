require 'rails_helper'

RSpec.describe Api::V1::AttendancesController, type: :controller do
  render_views
  let!(:meeting) { FactoryGirl.create(:meeting) }
  let(:user) { FactoryGirl.create(:user) }
  let(:student_id) { FactoryGirl.create(:ldap_credential, user: user).student_id }
  let(:access_token) do
    ApiKey.new.tap do |api_key|
      api_key.generate_access_token!
      api_key.save!
    end.access_token
  end

  describe '#create' do
    before do
      post :create, access_token: access_token, student_id: student_id
    end

    it 'returns success response' do
      expect(response).to be_ok
      expect(response).to render_template('create')
    end

    context 'when access at out time of meeting' do
      let!(:meeting) { FactoryGirl.create(:meeting, start_at: 30.minutes.since) }

      it 'returns error response' do
        expect(response).to be_error
        expect(response.body).to eq({ error: 'Not found meeting at current time.' }.to_json)
      end
    end

    context 'when set invalid student_id' do
      let(:student_id) { '12345678' }

      it 'returns error response' do
        expect(response).to be_error
        expect(response.body).to eq({ error: 'Not found user with student id.' }.to_json)
      end
    end

    context 'when attend duplicate with same meeting' do
      before do
        post :create, access_token: access_token, student_id: student_id
      end

      it 'returns error response' do
        expect(response).to be_error
        expect(response.body).to eq({ error: 'Duplicated attendance.' }.to_json)
      end
    end
  end
end
