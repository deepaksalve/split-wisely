require "faker"

describe "#Signup process", :type => :feature do
  before(:each) do
    @user = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: "ruby123",
      password_confirmation: "ruby123"
    }
  end

  context "when #email is invalid" do
    user = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: "invalid@",
      password: "ruby123",
      password_confirmation: "ruby123"
    }

    include_examples "signup failure", user, "Email is invalid"
  end

  context "when #email is blank" do
    user = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: "",
      password: "ruby123",
      password_confirmation: "ruby123"
    }

    include_examples "signup failure", user, "Email can't be blank"
  end

  context "when #password and #password_confirmation does not match" do
    user = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: "ruby123",
      password_confirmation: "ruby"
    }

    include_examples "signup failure", user, "Password confirmation doesn't match"
  end

  context "when user enters correct details" do
    it "allows user to signup" do
      visit new_user_registration_path

      within("#new_user") do
        fill_in "user_first_name", with: Faker::Name.first_name
        fill_in "user_last_name", with: Faker::Name.last_name
        fill_in "user_email", with: Faker::Internet.email
        fill_in "user_password", with: "ruby123"
        fill_in "user_password_confirmation", with: "ruby123"
      end

      click_button "Sign up"

      expect(page).to have_content "Welcome! You have signed up successfully."
    end
  end
end
