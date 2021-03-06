require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:role) }
  end

  context 'associations' do
    it { is_expected.to have_many(:uploads) }
    it { is_expected.to have_many(:comments) }
  end

  it { is_expected.to enumerize(:role).in(:guest, :user, :mod, :admin).with_default(:guest) }

  describe '#confirm' do
    let(:user) { create(:user, :unconfirmed) }
    it { expect { user.confirm }.to change { user.role }.from('guest').to('user') }
  end

  describe '.find_first_by_auth_conditions' do
    let(:user) { create(:user) }
    subject { described_class.find_first_by_auth_conditions(conditions) }

    context 'by :login with email' do
      context 'found' do
        let(:conditions) { { login: user.email } }
        it { is_expected.to eq(user) }
      end

      context 'not found' do
        let(:conditions) { { login: 'foo@bar.com' } }
        it { is_expected.to be(nil) }
      end
    end

    context 'by :login with username' do
      context 'found' do
        let(:conditions) { { login: user.username } }
        it { is_expected.to eq(user) }
      end

      context 'not found' do
        let(:conditions) { { login: 'foouser' } }
        it { is_expected.to be(nil) }
      end
    end

    context 'by :username' do
      context 'found' do
        let(:conditions) { { username: user.username } }
        it { is_expected.to eq(user) }
      end

      context 'not found' do
        let(:conditions) { { username: 'foouser' } }
        it { is_expected.to be(nil) }
      end
    end

    context 'by :email' do
      context 'found' do
        let(:conditions) { { email: user.email } }
        it { is_expected.to eq(user) }
      end

      context 'not found' do
        let(:conditions) { { email: 'foo@bar.com' } }
        it { is_expected.to be(nil) }
      end
    end
  end

  describe 'abilities' do
    subject(:ability) { Ability.new(user) }

    let(:user) { build(:user, role: role) }
    let(:upload) { build(:upload) }
    let(:comment) { build(:comment) }

    context 'guest' do
      let(:role) { :guest }

      context 'uploads' do
        it { is_expected.not_to be_able_to(:create, upload) }
        it { is_expected.to be_able_to(:read, upload) }
        it { is_expected.not_to be_able_to(:edit, upload) }
        it { is_expected.not_to be_able_to(:destroy, upload) }
      end

      context 'comments' do
        it { is_expected.not_to be_able_to(:create, comment) }
        it { is_expected.to be_able_to(:read, comment) }
        it { is_expected.not_to be_able_to(:edit, comment) }
        it { is_expected.not_to be_able_to(:destroy, comment) }
      end
    end

    context 'user' do
      let(:role) { :user }

      context 'uploads' do
        it { is_expected.to be_able_to(:create, upload) }
        it { is_expected.to be_able_to(:read, upload) }
        it { is_expected.not_to be_able_to(:edit, upload) }
        it { is_expected.not_to be_able_to(:destroy, upload) }
      end

      context 'comments' do
        it { is_expected.to be_able_to(:create, comment) }
        it { is_expected.to be_able_to(:read, comment) }
        it { is_expected.not_to be_able_to(:edit, comment) }
        it { is_expected.not_to be_able_to(:destroy, comment) }
      end
    end

    context 'mod' do
      let(:role) { :mod }

      context 'uploads' do
        it { is_expected.to be_able_to(:create, upload) }
        it { is_expected.to be_able_to(:read, upload) }
        it { is_expected.not_to be_able_to(:edit, upload) }
        it { is_expected.to be_able_to(:destroy, upload) }
      end

      context 'comments' do
        it { is_expected.to be_able_to(:create, comment) }
        it { is_expected.to be_able_to(:read, comment) }
        it { is_expected.not_to be_able_to(:edit, comment) }
        it { is_expected.to be_able_to(:destroy, comment) }
      end
    end

    context 'admin' do
      let(:role) { :admin }

      context 'uploads' do
        it { is_expected.to be_able_to(:create, upload) }
        it { is_expected.to be_able_to(:read, upload) }
        it { is_expected.to be_able_to(:edit, upload) }
        it { is_expected.to be_able_to(:destroy, upload) }
      end

      context 'comments' do
        it { is_expected.to be_able_to(:create, comment) }
        it { is_expected.to be_able_to(:read, comment) }
        it { is_expected.to be_able_to(:edit, comment) }
        it { is_expected.to be_able_to(:destroy, comment) }
      end
    end
  end
end
