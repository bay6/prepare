require 'spec_helper'

describe "UserPage" do
  subject { page }
  before { visit signup_path }
  it { should have_content('Sign Up') }
  it { should have_title(full_title('Sign Up')) }

end
