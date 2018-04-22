require 'rails_helper'

RSpec.describe Api::V1::AttendancesController, type: :controller do
  render_views
  let!(:meeting) { FactoryGirl.create(:meeting) }
  let(:user) { FactoryGirl.create(:user) }
  let(:student_id) { user.ldap_credential.student_id }
  let(:access_token) { FactoryGirl.create(:api_key).access_token }

  describe '#create' do
    before do
      post :create, access_token: access_token, student_id: student_id
    end

    it 'returns success response' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('create')
    end

    context 'when access at out time of meeting' do
      let!(:meeting) { FactoryGirl.create(:meeting, start_at: 30.minutes.since) }

      it 'returns error response' do
        expect(response).to have_http_status(:forbidden)
        expect(response.body).to eq({ error: 'No meeting in progress at this time.' }.to_json)
      end
    end

    context 'when set invalid student_id' do
      let(:student_id) { '12345678' }

      it 'returns error response' do
        expect(response).to have_http_status(:forbidden)
        expect(response.body).to eq({ error: 'No user found with specified student ID.' }.to_json)
      end
    end

    context 'when attend duplicate with same meeting' do
      before do
        post :create, access_token: access_token, student_id: student_id
      end

      it 'returns error response' do
        expect(response).to have_http_status(:conflict)
        expect(response.body).to eq({ error: 'Attendance already registered for current meeting.' }.to_json)
      end
    end
  end
end
