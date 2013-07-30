require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }
    
    it { should have_selector('h1', text: 'Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "profile page" do
    # let(:user) { User.create(name: "xiongbo", email: "reg027@qq.com",
                              #password: "foobar", password_confirmation: "foobar") }
    let(:user) { User.first }
    before { visit user_url(user) }

    it { should have_title(user.name) }
    it { should have_selector('h1', text: user.name) }
  end
end
