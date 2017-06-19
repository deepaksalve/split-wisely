describe "#Signin process", :type => :feature do
  before :each do
    @user = FactoryGirl.create(:user)
  end

  context 'when user enters invalid credentials' do
    it "does not allows user to sign in" do
      visit new_user_session_path

      within("#new_user") do
        fill_in 'user_email', with: @user.email
        fill_in 'user_password', with: ''
      end

      click_button 'Log in'

      expect(page).to have_content 'Invalid Email or password.'
    end
  end

  context 'when user enters correct credentials' do
    it "allows user to sign in" do
      visit new_user_session_path

      within("#new_user") do
        fill_in 'user_email', with: @user.email
        fill_in 'user_password', with: @user.password
      end

      click_button 'Log in'

      expect(page).to have_content 'Signed in successfully.'
    end
  end

end
