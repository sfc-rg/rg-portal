require 'rails_helper'

describe User, type: :model do
  let(:user) { FactoryGirl.create(:user, ldap_credential: ldap_credential, groups: groups) }
  let(:groups) { [FactoryGirl.create(:group)] }
  let(:ldap_credential) { FactoryGirl.create(:ldap_credential) }

  describe '#active?' do
    subject { user.active? }

    context 'when have ldap_credential and some groups' do
      it { is_expected.to be_truthy }
    end

    context 'when not have any groups' do
      let(:groups) { [] }
      it { is_expected.to be_falsey }
    end

    context 'when not have ldap_credential' do
      let(:ldap_credential) { nil }
      it { is_expected.to be_falsey }
    end
  end
end
