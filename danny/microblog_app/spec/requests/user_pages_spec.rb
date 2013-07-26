require 'spec_helper'

describe "UserPages" do
	# subject{page}

  describe "signup page" do
		before { visit signup_path }
    it "have the content 'Signup' " do
    	expect(page).to have_content("Signup Page")
    end
    it "have the title 'Signup' " do
    	expect(page).to have_title(full_title "Signup")
    end
  end
  describe "profile page" do
  	let(:user) {FactoryGirl.create(:user)}
		before { visit user_path(user) }
    # it { should have_content(user.name)}
    # it { should have_title(full_title user.name)}
    it "got right content  " do
    	expect(page).to have_content(user.name)
    end
    it "got right title " do
    	expect(page).to have_title(full_title user.name)
    end
  end



end
