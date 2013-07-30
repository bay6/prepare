require 'spec_helper'

describe Micropost do
	let(:user){FactoryGirl.create(:user)}
	before do
		@micropost = user.microposts.build(content: "HelloWorld")
	end
  it "respond to content " do
  	expect(@micropost).to respond_to(:content)
  end
  it "respond to user_id " do
  	expect(@micropost).to respond_to(:user_id)
  end
  it "respond to user " do
  	expect(@micropost).to respond_to(:user)
  end
  it "micropost's user is the user" do
  	expect(@micropost.user).to eq (user)
  end

  it "user id must be present" do
  	@micropost.user_id = nil
  	expect(@micropost).to be_invalid
  end

  it "content can not be blank" do
  	@micropost.content = ""
  	expect(@micropost).to be_invalid
  end
  it "content less than 140 words" do
  	@micropost.content = "a" *141
  	expect(@micropost).to be_invalid
  end



end
