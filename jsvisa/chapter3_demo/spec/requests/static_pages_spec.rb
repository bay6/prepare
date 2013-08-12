require 'spec_helper'


describe "Static pages" do

  subject { page }
  shared_examples_for "all static pages" do
    it { should have_content(heading) }
    it { should have_title(full_title(page_title)) }
  end

	describe "Home page" do
    before { visit root_path }
    let(:heading) { "Sample App" }
    let(:page_title) { "" }

    it_should_behave_like "all static pages"
    it { should_not have_title('| Home') }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Haha") 
        FactoryGirl.create(:micropost, user: user, content: "Have a lunch") 
        visit signin_path
        valid_signin user
        visit root_path
      end

      it "should render user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end
	 end

	describe "Help page" do
    before { visit help_path }
    let(:heading) { "Help" }
    let(:page_title) { "Help" }

    it_should_behave_like "all static pages"

	  #it "should have the content 'Help' and the title 'Help'" do
		#  visit help_path
	  #    expect(page).to have_content('Help')
	  #    expect(page).to have_title("#{base_title} | Help")
	  #end
	end

	describe "About page" do
    before { visit about_path }
    let(:heading) { "About us" }
    let(:page_title) { "About" }

    it_should_behave_like "all static pages"

	  #it "should have the content 'About us' and the title 'About'" do
		#  visit about_path
	  #    expect(page).to have_content('About us')
	  #    expect(page).to have_title("#{base_title} | About")
	  #end
	end

	describe "Contact page" do
    before { visit contact_path }
    let(:heading) { "Contact" }
    let(:page_title) { "Contact" }

    it_should_behave_like "all static pages"

	  #it "should have the content 'Contact' and the title 'Contact'" do
	  #  visit contact_path
	  #    expect(page).to have_content('Contact')
	  #    expect(page).to have_title("#{base_title} | Contact")
	  #end
	end

  describe "Right links" do
    it "should have the right links on the layout" do
      visit root_path
      click_link "About"
      expect(page).to have_title(full_title("About")) 
      click_link "Help"
      expect(page).to have_title(full_title("Help")) 
      click_link "Contact"
      expect(page).to have_title(full_title("Contact")) 
      click_link "Home"
      click_link "Sign up now!"
      expect(page).to have_title(full_title("Sign Up")) 
    end
  end
 
end


