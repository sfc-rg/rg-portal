require 'rails_helper'

RSpec.describe LdapCredential, type: :model do
  describe '.import' do
    let(:user) { FactoryGirl.create(:user) }
    let(:info_params) { FactoryGirl.attributes_for(:ldap_credential) }
    subject(:ldap_credential) { LdapCredential.import(user: user, info: info_params) }

    it 'returns ldap credential' do
      expect(ldap_credential).to be_present
      expect(ldap_credential).to be_a(LdapCredential)
    end

    it 'returns not saved' do
      expect(ldap_credential.new_record?).to be_truthy
    end
  end
end
