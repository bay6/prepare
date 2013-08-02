require 'spec_helper'

describe "MicropostPages" do
	let(:user){FactoryGirl.create(:user)}
	before { sign_in user}

  describe "creation of micropost" do
  	before {visit root_path}

  	describe "with invalid information" do
  		it "should not create a micropost" do
  			expect{click_button "Post"}.not_to change(Micropost,:count)
  			expect(page).to have_content('error')
  		end

  	end
  	describe "with valid information" do
  		before { fill_in 'micropost_content', with: "Lorem ipsum" }
  		it "should create a micropost" do
  			expect{click_button "Post"}.to change(Micropost,:count).by(1)
  		end
  	end
  end

  describe "destruction of micropost" do
    before do
      FactoryGirl.create(:micropost, user: user)
    end
    describe "as correct user" do
      before {visit root_path}
      it "delete a micropost" do
        expect{click_link "delete"}.to change(Micropost, :count).by(-1)
      end
    end
  end
end
