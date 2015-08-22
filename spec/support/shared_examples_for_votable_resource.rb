RSpec.shared_examples 'votable resource' do
  login_user

  let(:model) { described_class.controller_name.singularize.camelize.constantize }
  let(:model_name) { model.name.downcase.to_sym }

  describe 'POST #upvote' do
    let(:resource) { create(model_name) }

    it 'increments the score by 1' do
      expect do
        post :upvote, id: resource.id
        resource.reload
      end.to change { resource.weighted_score }.from(0).to(1)
    end

    it 'sets the status code 200' do
      expect(response).to be_ok
    end
  end

  describe 'POST #downvote' do
    let(:resource) { create(model_name) }

    it 'decrements the score by 1' do
      expect do
        post :downvote, id: resource.id
        resource.reload
      end.to change { resource.weighted_score }.from(0).to(-1)
    end

    it 'sets the status code 200' do
      expect(response).to be_ok
    end
  end

  describe 'DELETE #unvote' do
    let(:resource) { create(model_name) }

    before do
      post :upvote, id: resource.id
      resource.reload
    end

    it 'removes the user\'s vote' do
      expect do
        post :unvote, id: resource.id
        resource.reload
      end.to change { resource.weighted_score }.from(1).to(0)
    end

    it 'sets the status code 200' do
      expect(response).to be_ok
    end
  end
end
