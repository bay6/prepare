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
      it { should have_link('Users',       href: users_path) }
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

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title("Sign in") }
        end

        describe "when attempting to visit a protected page" do
          before do
            visit edit_user_path(user)
            valid_signin(user)
          end
          
          describe "after signing in" do
            it { should have_title("Edit user") }
          end

          describe "when signing in again" do
            before do
              delete signout_path
              visit signin_path
              valid_signin(user)
            end

            it "should render the default (profile) page " do
              expect(page).to have_title(user.name)
            end
          end
        end
      end

      describe "in the Microposts controller" do
        
        describe "submitting to the create action" do
          before { post microposts_path }
          specify { expect(response).to redirect_to signin_path }
        end

        describe "submitting to the destroy action" do
          before { delete micropost_path(FactoryGirl.create(:micropost)) }
          specify { expect(response).to redirect_to signin_path }
        end
      end

      describe "as wrong user" do
        let(:user) { FactoryGirl.create(:user) }
        let(:wrong_user) do
          FactoryGirl.create(:user, email: "wrong@example.com")
        end
        before do
          visit signin_path
          valid_signin user, no_capybara: true 
        end

        describe "visiting Users#edit page" do
          before { visit edit_user_path(wrong_user) }
          it { should_not have_title(full_title('Edit user')) }
        end

        describe "submitting a PATCH request to the Users#update action" do
          before { patch user_path(wrong_user) }
          specify { expect(response).to redirect_to(root_path) }
        end
      end

      describe "as non-admin user" do
        let(:user) { FactoryGirl.create(:user) }
        let(:non_admin) { FactoryGirl.create(:user) }
        before do
          visit signin_path
          valid_signin non_admin, no_capybara: true 
        end

        describe "submitting a DELETE request to the Users#destroy action" do
          before { delete user_path(user) }
          specify { expect(response).to redirect_to(root_path) }
        end
      end
      
    end

  end
end

