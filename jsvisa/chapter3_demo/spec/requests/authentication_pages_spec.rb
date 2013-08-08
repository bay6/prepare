require 'spec_helper'

describe "AuthenticationPages" do

  subject { page }

  describe "sign in page" do
    before { visit signin_path }

    it { should have_title("Sign in") }
    it { should have_content("Sign in") }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title("Sign in") } 
      it { should have_error_message("Invalid") }

      describe "after visit another page" do
        before { click_link "Home" }
        it { should_not have_selector("div.alert.alert-error") }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { valid_signin(user) }

      it { should have_title(user.name) }
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Setting',     href: edit_user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by sign_out" do
        before { click_link "Sign out" }

        it { should have_link("Sign in") }
      end
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      
      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }

          it { should have_title("Sign in") }
        end

        describe "submitting to the user path" do
          before { patch user_path(user) }

          specify { expect(response).to redirect_to signin_path }
        end
      end

    end
  end

end
