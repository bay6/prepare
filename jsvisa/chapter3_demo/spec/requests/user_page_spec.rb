require 'spec_helper'


describe "UserPage" do

  subject { page }

  describe "Sign up" do
    before { visit signup_path }
    let(:submit) { "Create my account" }

    it { should have_content('Sign Up') }
    it { should have_title(full_title('Sign Up')) }

    describe "with invalid information" do
      it "should not create an empty account" do
        expect { click_button(submit) }.not_to change(User, :count)
      end

      describe "after commition" do
        before { click_button submit}

        it { should_not have_title("Sign up") }
        it { should have_content("error") }
      end
    end

    describe "with valid information" do
      before { fill_in_valid_signup }
      
      it "should create an accout" do
        expect { click_button(submit) }.to change(User, :count).by(1) 
      end

      describe "after saving the user" do
        before { click_button submit}
        let(:user) { User.find_by(email: "example@gmail.com") }

        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end

    end
  end

  describe "page profile" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

end
