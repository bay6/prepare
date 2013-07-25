require 'spec_helper'

#describe "StaticPages" do
#  describe "GET /static_pages" do
#    it "works! (now write some real specs)" do
#      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#      get static_pages_index_path
#      response.status.should be(200)
#    end
#  end
#end

describe "Static pages" do

	describe "Home page" do

	    it "should have the right content and title 'Sample App'" do
		    visit '/static_pages/home'
	        expect(page).to have_content('Sample App')
	        expect(page).to have_title('Chapter3Demo | Home')
	    end
	end

	describe "Help page" do

	    it "should have the content 'Help' and the title 'Help'" do
		    visit '/static_pages/help'
	        expect(page).to have_content('Help')
	        expect(page).to have_title('Chapter3Demo | Help')
	    end
	end

	describe "About page" do

	    it "should have the content 'About us' and the title 'About'" do
		    visit '/static_pages/about'
	        expect(page).to have_content('About us')
	        expect(page).to have_title('Chapter3Demo | About')
	    end
	end

	describe "Contact page" do

	    it "should have the content 'Contact' and the title 'Contact'" do
		    visit '/static_pages/contact'
	        expect(page).to have_content('Contact')
	        expect(page).to have_title('Chapter3Demo | Contact')
	    end
	end

end

