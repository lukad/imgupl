require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  context 'associations' do
    it { is_expected.to have_many(:uploads) }
  end

  describe '.find_first_by_auth_conditions' do
    let(:user) { create(:user) }
    subject { described_class.find_first_by_auth_conditions(login: login) }

    context 'by email' do
      context 'found' do
        let(:login) { user.email }
        it { is_expected.to eq(user) }
      end

      context 'not found' do
        let(:login) { 'foo@bar.com' }
        it { is_expected.to be(nil) }
      end
    end

    context 'by username' do
      context 'found' do
        let(:login) { user.username }
        it { is_expected.to eq(user) }
      end

      context 'not found' do
        let(:login) { 'foouser' }
        it { is_expected.to be(nil) }
      end
    end
  end
end
