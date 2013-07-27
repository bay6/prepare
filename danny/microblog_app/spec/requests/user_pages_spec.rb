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

  describe "signup with valid information" do
  	let(:submit){'Create my account'}
  	before do
  		visit signup_path
  		fill_in "Name", :with => 'good'
  		fill_in 'Email', :with => 'good@gmail.com'
  		fill_in 'Password', :with => 'goodruby'
  		fill_in 'Confirmation', :with => 'goodruby'
  		click_button submit
  	end
  	let(:user){ User.find_by(email: 'good')}
  	it { should change(User.count).by(1) }
  	it {shoule have_title(user.name)}
  	it {shoud have_select('div.alert-success') }

  end



end
