
describe GroupsController, :type => :controller do
  context 'when user is not logged in' do
    describe 'GET #new' do
      it 'returns http redirect status' do
        get :new
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  context 'when user is logged in' do
    login_user

    describe 'GET #new' do
      it 'returns http success' do
        get :new
        expect(response).to have_http_status(:success)
      end
    end
  end
end
