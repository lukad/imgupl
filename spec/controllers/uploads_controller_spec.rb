require 'rails_helper'

describe UploadsController do
  describe 'GET index' do
    let(:uploads) { [] }

    before do
      allow(Upload).to receive(:order) { double(limit: uploads) }
      get :index
    end

    it 'returns 200' do
      expect(response).to be_ok
    end

    it 'fetches the 50 newest uploads' do
      expect(assigns(:uploads)).to eq(uploads)
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end
  end

  describe 'GET show' do
    let(:upload) { create(:upload) }

    before do
      get :show, id: upload.id
    end

    it 'returns 200' do
      expect(response).to be_ok
    end

    it 'assigns the correct upload' do
      expect(assigns(:upload)).to eq(upload)
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end
  end

  describe 'GET new' do
    login_user
    let!(:upload) { Upload.new }

    before do
      allow(Upload).to receive(:new) { upload }
      get :new
    end

    it 'returns 200' do
      expect(response).to be_ok
    end

    it 'assigns a new upload' do
      expect(assigns(:upload)).to eq(upload)
    end

    it 'renders the show template' do
      expect(response).to render_template('new')
    end
  end

  describe 'POST create' do
    login_user

    before do
      post :create, upload: upload_params
    end

    context 'when image is valid' do
      let(:upload_params) { attributes_for(:upload) }

      it 'redirects to the upload' do
        expect(response).to redirect_to(upload_path(Upload.last))
      end
    end

    context 'when image is invalid' do
      let(:upload_params) { attributes_for(:upload, image: nil) }

      it 'renders new' do
        expect(response).to render_template('new')
      end

      it 'sets the status 422 unprocessable entity' do
        expect(response.status).to be(422)
      end
    end
  end

  describe '' do
    login_mod
    let(:upload) { create(:upload) }

    before do
      delete :destroy, id: upload.id
    end

    it 'destroys the upload' do
      expect(Upload.where(id: upload.id)).not_to exist
    end

    it 'redirects to the uploads path' do
      expect(response).to redirect_to(uploads_path)
    end
  end
end
