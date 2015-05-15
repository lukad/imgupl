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
      let(:user) { build(:user, admin: true) }
      it { expect(response.body).to eq('ok') }
    end
  end
end
