require 'rails_helper'

RSpec.describe LineIntegrationController, type: :controller do
  render_views
  let(:dummy_reply_token) { 'dummyReplyToken' }
  let(:dummy_line_id) { 'dummyLineId' }

  describe '#associate' do
    let(:user) { FactoryGirl.create(:user) }
    let(:line_credential) { FactoryGirl.create(:line_credential, user: nil) }
    let(:associate_key) { line_credential.associate_key }
    before { login_as_user }

    subject { get :associate, ak: associate_key }

    context 'when access correct associate_key' do
      it { is_expected.to be_ok }
      it { is_expected.to render_template :associate }
    end

    context 'when access invalid associate_key' do
      let(:associate_key) { 'invalid_key' }
      it { is_expected.to be_forbidden }
    end

    context 'when access correct associate_key with already associated' do
      let(:line_credential) { FactoryGirl.create(:line_credential, user: user) }
      it { is_expected.to be_forbidden }
    end
  end

  describe '#do_associate' do
    let(:user) { FactoryGirl.create(:user) }
    let(:line_credential) { FactoryGirl.create(:line_credential, user: nil) }
    let(:associate_key) { line_credential.associate_key }
    before { login_as_user(user) }
    before do
      allow(LineClient).to receive(:push_message)
    end

    subject { post :do_associate, ak: associate_key }

    context 'when access correct associate_key' do
      it { is_expected.to be_ok }
      it { is_expected.to render_template :do_associate }

      it 'calls line client push_message' do
        subject
        expect(LineClient).to have_received(:push_message).once
      end
    end

    context 'when access invalid associate_key' do
      let(:associate_key) { 'invalid_key' }
      it { is_expected.to be_forbidden }
    end

    context 'when access correct associate_key with already associated' do
      let(:line_credential) { FactoryGirl.create(:line_credential, user: user) }
      it { is_expected.to be_forbidden }
    end
  end

  describe '#callback' do
    let(:profile_json) do
      {
        displayName: "LINE taro",
        userId: dummy_line_id,
        pictureUrl: "http://obs.line-apps.com/ub00b9ac609e51f4707cd86d8e797491b/1",
        statusMessage: "Hello, LINE!"
      }
    end
    let(:request_json) do
      { events: [ event_json ] }
    end
    before do
      allow(LineClient).to receive(:validate_signature).and_return(true)
      allow(LineClient).to receive(:get_profile).and_return(profile_json)
      allow(LineClient).to receive(:reply_message)
    end

    subject { post :callback, request_json.to_json, format: :json }

    describe 'on follow' do
      let(:event_json) do
        {
          replyToken: dummy_reply_token,
          type: "follow",
          timestamp: 1462629479859,
          source: {
            type: "user",
            userId: dummy_line_id
          }
        }
      end

      context 'at first time' do
        it { is_expected.to be_ok }

        it 'creates line credential' do
          expect{ subject }.to change{ LineCredential.count }.by(1)
        end

        it 'calls line client reply_message' do
          subject
          associate_url = associate_line_url(ak: LineCredential.last.associate_key)
          expect(LineClient).to have_received(:reply_message) do |token, message|
            expect(message[:text].include?(associate_url)).to be_truthy
          end
        end
      end

      context 'already associated' do
        let(:line_credential) { FactoryGirl.create(:line_credential) }
        let(:dummy_line_id) { line_credential.encrypted_line_user_id }

        it 'does not create line credential' do
          expect{ subject }.not_to change{ LineCredential.count }
        end

        it 'does not call line client reply_message' do
          subject
          expect(LineClient).not_to have_received(:reply_message)
        end
      end
    end

    describe 'on unfollow' do
      let(:event_json) do
        {
          type: "unfollow",
          timestamp: 1462629479859,
          source: {
            type: "user",
            userId: dummy_line_id
          }
        }
      end
      let(:line_credential) { FactoryGirl.create(:line_credential) }
      let(:dummy_line_id) { line_credential.encrypted_line_user_id }
      let!(:meeting) { FactoryGirl.create(:meeting) }

      it { is_expected.to be_ok }

      it 'updates unfollowed_at' do
        expect{ subject }.to change{ line_credential.reload.unfollowed_at.present? }.from(false).to(true)
      end
    end

    describe 'on beacon' do
      let(:beacon_hw_id) { 'd41d8cd98f' }
      let(:event_json) do
        {
          replyToken: dummy_reply_token,
          type: "beacon",
          timestamp: 1462629479859,
          source: {
            type: "user",
            userId: dummy_line_id
          },
          beacon: {
            hwid: beacon_hw_id,
            type: "enter"
          }
        }
      end
      let(:line_credential) { FactoryGirl.create(:line_credential) }
      let(:dummy_line_id) { line_credential.encrypted_line_user_id }
      let!(:meeting) { FactoryGirl.create(:meeting) }

      it { is_expected.to be_ok }

      it 'creates meeting attendance' do
        expect{ subject }.to change{ MeetingAttendance.find_by(user: line_credential.user, meeting: meeting).present? }.from(false).to(true)

        message = {
          type: 'text',
          text: "#{meeting.name}に出席しました！"
        }
        expect(LineClient).to have_received(:reply_message).with(dummy_reply_token, message).once
      end
    end
  end
end
