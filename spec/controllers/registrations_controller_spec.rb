
RSpec.describe RegistrationsController, :type => :controller do
  context 'when user is not logged in' do
    it "should not have a current_user" do
      expect(subject.current_user).to eq(nil)
    end
  end

  context 'when user is logged in' do
    login_user

    it "should have a current_user" do
      expect(subject.current_user).to_not eq(nil)
    end
  end
end
