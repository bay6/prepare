require 'spec_helper'

describe "MicropostPages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before do
    visit signin_path
    valid_signin user 
  end

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do
      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error message" do
        before { click_button "Post" } 
        it { should have_content("error") }
      end
    end

    describe "with valid information" do
      before do
        fill_in "micropost_content", with: "Hello world"
      end
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end
end
