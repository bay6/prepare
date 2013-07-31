require 'spec_helper'

describe "StaticPages" do
  it "have right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title("About Us")
    click_link "Help"
    expect(page).to have_title("Help")
    click_link "Contact"
    expect(page).to have_title("Contact")
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title("Signup")
  end
  
  # subject { page }
  describe "Home page" do
    before { visit root_path }
    it "should have the content 'Microblog App' " do
      expect(page).to have_content('Microblog App')
    end
    # it {should have_content('Microblog App')}

    it "should have the title 'Home' " do
      expect(page).to have_title(full_title("Home"))
    end

  end
  describe "Help page" do
    before { visit help_path }
    it "should have the content 'Help' " do
      expect(page).to have_content('Help')
    end
    it "should have the title 'Help' " do
      expect(page).to have_title(full_title "Help")
    end
  end

  describe "About page" do
    before { visit about_path }
    it "should have the content 'About' " do
      expect(page).to have_content('About')
    end
    it "should have the title 'About Us' " do
      expect(page).to have_title(full_title "About Us")
    end
  end

  describe "Contact Page" do
    before { visit contact_path }
  	it "should have the content 'Contact' " do
	  	expect(page).to have_title(full_title "Contact")
  	end
  end

  describe "Home page" do
    describe "for signed in users" do
      let(:user){ FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user:user, content:"good")
        FactoryGirl.create(:micropost, user:user, content:"bad")
        sign_in user
        visit root_path
      end
      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text:item.content)
        end
      end
    end
  end

end
