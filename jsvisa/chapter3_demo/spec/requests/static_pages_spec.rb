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
  #let(:base_title) { "Chapter3Demo" }

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

	  #it "should have the right content and title 'Sample App'" do
		#  visit root_path
	  #    expect(page).to have_content('Sample App')
	  #    expect(page).to have_title("#{base_title}")
		#    expect(page).not_to have_title("Home")
	  #end
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

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title("About")) 
#    it { should have_title(full_title("About us")) }
    click_link "Help"
    expect(page).to have_title(full_title("Help")) 
    click_link "Contact"
    expect(page).to have_title(full_title("Contact")) 
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title(full_title("Sign Up")) 
  end
 
#  describe "Right links" do
#  before { visit root_path }
#  click_link "About"
#  it { should have_title(full_title("About")) }
end


