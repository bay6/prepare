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

  describe "signup " do
  	describe "with valid information" do

	  	before do
	  		visit signup_path
	  		fill_in "Name", :with => 'good'
	  		fill_in 'Email', :with => 'good@gmail.com'
	  		fill_in 'Password', :with => 'goodruby'
	  		fill_in 'Confirmation', :with => 'goodruby'
	  	end
	  	let(:submit){'Create my account'}

	  	it "should create a new user" do
		  	expect{click_button submit}.to change(User,:count).by(1)
	  	end
	  	describe "after submisson" do
	  		before {click_button submit}
		  	it "will got info page of new user" do
		  		user = User.find_by(email: 'good@gmail.com')
		  		expect(page).to have_title(user.name)
		  		expect(page).to have_selector('div.alert.alert-success')
		  	end
		  end

  	end
  	describe "with invalid information" do
  		
	  	before do
	  		visit signup_path
	  		fill_in "Name", :with => ''
	  		fill_in 'Email', :with => ''
	  		fill_in 'Password', :with => ''
	  		fill_in 'Confirmation', :with => ''
	  	end
	  	let(:submit){'Create my account'}

	  	it "should create a new user" do
		  	expect{click_button submit}.not_to change(User,:count)
	  	end
	  	describe "after submisson" do
	  		before {click_button submit}
		  	it "will got errors message" do
		  		expect(page).to have_title("Signup")
		  		expect(page).to have_content('error')
		  	end
		  end

  	end

  end



end
