require 'rails_helper'

RSpec.describe UploadsController, type: :controller do
  render_views
  before { login_as_user }
  let(:upload) { FactoryGirl.create(:upload) }

  describe '#index' do
    before { get :index }

    it 'renders index action' do
      expect(response).to render_template(:index)
    end
  end

  describe '#create' do
    let(:param) { { file: fixture_file_upload('images/arch_square.png', 'image/png') } }

    context 'when request with form' do
      before { post :create, upload: param }

      it 'redirects uploads#index' do
        expect(response).to be_redirect
        expect(response).to redirect_to(uploads_path)
      end
    end

    context 'when request with xhr' do
      before { xhr :post, :create, upload: param }

      it 'renders json data' do
        expect(response).to be_success
      end
    end
  end

  describe '#show' do
    before { get :show, id: id }

    context 'when given exist id' do
      let(:id) { upload.id }

      it 'redirects to file' do
        expect(response).to redirect_to(file_upload_path(id: upload.id, filename: upload.file.file.filename))
      end
    end

    context 'when given not exist id' do
      let(:id) { upload.id + 100 }

      it 'renders empty' do
        expect(response).to render_template(nil)
      end
    end
  end

  describe '#file' do
    before { get :show, id: id, filename: filename }

    context 'when given exist id and exist filename' do
      let(:id) { upload.id }
      let(:filename) { upload.file.file.filename }

      it 'send file' do
        expect(response.body).to be_truthy
      end
    end

    context 'when given exist id and not exist filename' do
      let(:id) { upload.id }
      let(:filename) { "invalid-#{upload.file.file.filename}" }

      it 'redirects to file' do
        expect(response).to be_redirect
        expect(response).to redirect_to(file_upload_path(id: upload.id, filename: upload.file.file.filename))
      end
    end

    context 'when given not exist id' do
      let(:id) { upload.id + 100 }
      let(:filename) { upload.file.file.filename }

      it 'renders empty' do
        expect(response).to be_success
        expect(response).to render_template(nil)
      end
    end
  end
end
