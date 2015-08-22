require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  it_behaves_like 'votable resource'

  describe 'POST #create' do
    login_user
    let(:comment) { build :comment }
    before { post :create, comment: comment.attributes, upload_id: comment.upload.id }

    it { is_expected.to redirect_to(upload_path(comment.upload)) }
    it { is_expected.to set_flash[:success] }
  end

  describe 'DELETE #destroy' do
    login_mod
    let(:comment) { create :comment }
    before { delete :destroy, id: comment.id, upload_id: comment.upload.id }

    it { is_expected.to set_flash[:success] }
  end
end
