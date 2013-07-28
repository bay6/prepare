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

	let(:base_title){"Chapter3Demo"}

	describe "Home page" do

	    it "should have the right content and title 'Sample App'" do
		    visit root_path
	        expect(page).to have_content('Sample App')
	        expect(page).to have_title("#{base_title}")
			expect(page).not_to have_title("Home")
	    end
	end

	describe "Help page" do

	    it "should have the content 'Help' and the title 'Help'" do
		    visit help_path
	        expect(page).to have_content('Help')
	        expect(page).to have_title("#{base_title} | Help")
	    end
	end

	describe "About page" do

	    it "should have the content 'About us' and the title 'About'" do
		    visit about_path
	        expect(page).to have_content('About us')
	        expect(page).to have_title("#{base_title} | About")
	    end
	end

	describe "Contact page" do

	    it "should have the content 'Contact' and the title 'Contact'" do
		    visit contact_path
	        expect(page).to have_content('Contact')
	        expect(page).to have_title("#{base_title} | Contact")
	    end
	end

end

