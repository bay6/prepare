require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end
end

describe "signin" do
  before { visit signin_path }

  describe "with invalid information" do
    before { click_button "Sign in" }

    it { should have_title('Sign in') }
    it { should have_selector('div.alert.alert-error', text: 'Invalid') }
    
    describe "after visiting another page" do
      before { click_link "Home" }
      it { should_not have_selector('div.alert.alert-error') }
    end
  end
  
  it { should have_title(user.name) }
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
    end
end