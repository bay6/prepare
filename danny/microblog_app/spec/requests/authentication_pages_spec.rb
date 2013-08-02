require 'spec_helper'

describe "AuthenticationPages" do
	subject {page}
	describe "signin page" do
		before { visit signin_path}

		it { should have_content('Sign in')}
		it { should have_title('Sign in')}
  end

  describe "sign in" do
  	before { visit signin_path}
  	describe "with invalid informaiton" do
  		before { click_button "Signin"}
  		it {should have_title('Sign in')}
  		it {should have_selector('div.alert.alert-error', text:'Invalid')}

      describe "visiting another page" do
        before { click_link "Home"}
        it { should_not have_selector("div.alert.alert-error")}
      end
  	end

  	describe "with valid informaiton" do
  		let(:user) {FactoryGirl.create(:user)}
      before {sign_in(user)}
  		it {should have_title(user.name)}
  		it {should have_link("Profile", href:user_path(user))}
  		it {should have_link("Signout", href:signout_path)}
      it {should have_link("Setting",href:edit_user_path(user))}
  		it {should have_link("Users",href:users_path)}
      it {should_not have_link("Signin",href:signin_path)}


      describe "followed by signout" do
        before {click_link "Signout"}
        it { should have_link "Signin"}
      end


  	end
  end

  describe "authorization" do
    # let(:user) {FactoryGirl.create(:user)}
    describe "for non-signed-in user" do
      let(:user){FactoryGirl.create(:user)}

      #no Profile Setting
      describe "in head nav" do
        before {visit root_path}
        it "no Profile no Setting " do
          expect(page).not_to have_link('Profile')
          expect(page).not_to have_link('Setting')
        end
      end


      describe "visiting the edit page" do
        before { visit edit_user_path(user)}
        it "redirect to signin page" do
          expect(page).to have_title("Sign in")
        end
      end
      describe "submitting the update action" do
        before { patch user_path(user)}
        it "redirect to signin page" do
          expect(response).to redirect_to(signin_path)
        end
      end

      #index page
      describe "visiting the index page" do
        before {visit users_path}
        it "redirect to signin page" do
          expect(page).to have_title("Sign in")
        end
      end


      describe "when attempting to visiting a protected page" do
        before do
          visit edit_user_path(user) 
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "Signin"
        end
        describe "after sign in " do
          it "render the desired protected page" do
            expect(page).to have_title('Edit user')
          end
        end

      end
      ###Following and Fans
      describe "in the Users controller" do
        describe "visiting the following page" do
          before { visit following_user_path(user) }
          it { should have_title('Sign in') }
        end
        describe "visiting the fans page" do
          before { visit fans_user_path(user) }
          it { should have_title('Sign in') }
        end
      end

      #relationship actions
      describe "in the Relationships controller" do
        describe "submitting to the create action" do
          before { post relationships_path }
          specify { expect(response).to redirect_to(signin_path)}
        end
        describe "submitting to the destroy action" do
          before { delete relationship_path(1) }
          specify { expect(response).to redirect_to(signin_path)}
        end
      end
    end

    describe "for signed in user" do
      let(:user){FactoryGirl.create(:user)}
      let(:wrong_user){FactoryGirl.create(:user,
                                          email:"wrong@example.com")}

      describe "when visting other edit page" do
        before do
          sign_in(user, no_capbara: true)
          visit edit_user_path(wrong_user)
        end
        it "can not visiting edit page" do
          expect(page).not_to have_title("Edit user")
        end
      end
      describe "submitting a PATCH request to other update action" do
        before do
          sign_in(user, no_capbara: true)
          patch user_path(wrong_user)
        end
        it "will back to page" do
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "as non-admin user" do
      let(:user){FactoryGirl.create(:user)}
      let(:non_admin){FactoryGirl.create(:admin)}
      before {sign_in user, no_capbara:true}
      describe "submitting Delete click" do 
        before {delete user_path(user)}
        it "should redirect to home page" do          
          expect(response).to redirect_to(root_path)
        end
      end
    end
    describe "as admin user" do
      let(:admin){FactoryGirl.create(:admin)}
      before {sign_in admin, no_capbara:true}
      describe "Delete himself" do 
        before {delete user_path(admin)}
        it "should redirect to home page" do          
          expect(response).to redirect_to(root_path)
        end
      end
    end
##microposts
    describe "Opration of microposts" do
      let(:user){FactoryGirl.create(:user)}
      let(:micropost){FactoryGirl.create(:micropost)}
      describe "when no signedin user submitting create action" do
        before { post microposts_path }
        it "redirect to sign in page" do
          expect(response).to redirect_to(signin_path)
        end
      end
      describe "when no signedin user submitting delete action" do
        before { delete micropost_path(micropost)}
        it "redirect to sign in page" do
          expect(response).to redirect_to(signin_path)
        end
      end
    end
  end


end
