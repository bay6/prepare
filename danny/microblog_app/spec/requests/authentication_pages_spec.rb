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
  		before do
  			fill_in "Email", with: user.email.upcase 
  			fill_in "Password", with: user.password
  		  click_button "Signin"
  		end
  		it {should have_title(user.name)}
  		it {should have_link("Profile", href:user_path(user))}
  		it {should have_link("Signout", href:signout_path)}
  		it {should_not have_link("Signin",href:signin_path)}


      describe "followed by signout" do
        before {click_link "Signout"}
        it { should have_link "Signin"}
      end


  	end
  end


end
