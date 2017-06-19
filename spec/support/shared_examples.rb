
shared_examples "signup failure" do |user, message|
  it "does not allows user to signup" do
    visit new_user_registration_path

    within("#new_user") do
      fill_in "user_first_name", with: user[:first_name]
      fill_in "user_last_name", with: user[:last_name]
      fill_in "user_email", with: user[:email]
      fill_in "user_password", with: user[:password]
      fill_in "user_password_confirmation", with: user[:password_confirmation]
    end

    click_button "Sign up"

    expect(page).to have_content message
  end
end
