require 'spec_helper'

describe "AuthenticationPages" do
  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selecotr('h1', text: 'Sign in') }
    it { should have_title('Sign in') }
  end
end
