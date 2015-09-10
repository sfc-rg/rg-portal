require 'rails_helper'

RSpec.describe SettingsController, type: :controller do
  render_views
  let(:user) { FactoryGirl.create(:user) }

  describe '#update_ldap' do
    let(:username) { 'miyukki' }
    let(:password) { 'p@ssw0rd' }
    let(:student_id) { 71349640 }
    let(:ldap_bind_result) { true }
    let(:ldap_info_result) {
      double(:hash,
        uid: [ username ],
        gecos: ["Yusei Yamanaka, SFC, #{student_id}, t13964yy@sfc.keio.ac.jp"],
        uidnumber: ['11032'],
        gidnumber: ['1000'],
      )
    }
    before do
      session[:user_id] = user.id # logged in
      allow_any_instance_of(Net::LDAP).to receive(:bind).and_return(ldap_bind_result)
      allow_any_instance_of(Net::LDAP).to receive_message_chain(:search, :first).and_return(ldap_info_result)
      patch :update_ldap, ldap: { username: username, password: password }
    end

    context 'when correct credential' do
      context 'and receive valid old ldap user result' do
        let(:ldap_info_result) {
          double(:hash,
            uid: [ username ],
            gecos: ['miyukki,,,'],
            uidnumber: ['11032'],
            gidnumber: ['1000'],
          )
        }

        it 'saves ldap credential' do
          expect(user.ldap_credential).to be_present
          expect(user.ldap_credential.uid).to eq(username)
        end
        it 'does not save student_id in ldap credential' do
          expect(user.ldap_credential.student_id).to be_nil
        end
        it 'redirects edit profile page' do
          expect(response).to redirect_to(edit_profile_path)
        end
        it 'does not have any error flash message' do
          expect(flash[:error]).to be_blank
        end
      end
      context 'and receive valid newer ldap user result' do
        it 'saves ldap credential' do
          expect(user.ldap_credential).to be_present
          expect(user.ldap_credential.uid).to eq(username)
        end
        it 'saves student_id in ldap credential' do
          expect(user.ldap_credential.student_id).to eq(student_id)
        end
        it 'redirects edit profile page' do
          expect(response).to redirect_to(edit_profile_path)
        end
        it 'does not have any error flash message' do
          expect(flash[:error]).to be_blank
        end
      end
    end

    context 'when incorrect credential' do
      let(:ldap_bind_result) { false }

      it 'does not save ldap credential' do
        expect(user.ldap_credential).to be_blank
      end
      it 'redirects edit profile page' do
        expect(response).to redirect_to(edit_profile_path)
      end
      it 'shows error flash message' do
        expect(flash[:error]).to eq('認証情報が正しくありません')
      end
    end
  end
end
