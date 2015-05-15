require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#authenticate_admin_user!' do
    controller(described_class) do
      before_action :authenticate_admin_user!

      def index
        render text: 'ok'
      end
    end

    before { allow_any_instance_of(described_class).to receive(:current_user).and_return(user) }
    before { allow_any_instance_of(described_class).to receive(:skip_authorization?).and_return(true) }
    before { get :index }

    context 'user is not logged in' do
      let(:user) { nil }
      it { expect(response).to redirect_to(new_user_session_path) }
    end

    context 'user is not an admin' do
      let(:user) { build(:user) }
      it { expect(response).to redirect_to(root_path) }
    end

    context 'user is an admin' do
      let(:user) { build(:user, role: :admin) }
      it { expect(response.body).to eq('ok') }
    end
  end

  describe '#activeadmin_resource?' do
    let(:instance) { described_class.new }
    subject { instance.send(:activeadmin_resource?) }
    before { allow(instance.class).to receive(:ancestors).and_return(ancestors) }

    context 'is an active admin resource' do
      let(:ancestors) { [ActiveAdmin::BaseController] }
      it { is_expected.to be(true) }
    end

    context 'is not an active admin resource' do
      let(:ancestors) { [] }
      it { is_expected.to be(false) }
    end
  end

  describe '#skip_authorization?' do
    subject { described_class.new.send(:skip_authorization?) }
    before { allow_any_instance_of(described_class).to receive(:devise_controller?).and_return(devise_controller?) }
    before { allow_any_instance_of(described_class).to receive(:activeadmin_resource?).and_return(activeadmin_resource?) }

    context 'neither devise controller nor activeadmin resource' do
      let(:devise_controller?) { false }
      let(:activeadmin_resource?) { false }
      it { is_expected.to be(false) }
    end

    context 'devise controller but not activeadmin resource' do
      let(:devise_controller?) { true }
      let(:activeadmin_resource?) { false }
      it { is_expected.to be(true) }
    end

    context 'not devise controller but activeadmin resource' do
      let(:devise_controller?) { false }
      let(:activeadmin_resource?) { true }
      it { is_expected.to be(true) }
    end

    context 'devise controller and activeadmin resource' do
      let(:devise_controller?) { true }
      let(:activeadmin_resource?) { true }
      it { is_expected.to be(true) }
    end
  end
end
