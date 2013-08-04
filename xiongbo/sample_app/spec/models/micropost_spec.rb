# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Micropost do
  let(:user) { FactoryGirl.create(:user) }

  before do 
    @micropost = user.microposts.build(content: "Lorem ipsum")
  end

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should be_valid }
  its(:user) { should == user }

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  #describe "accessible attributes" do
  #  it "should not allow access to user_id" do
  #    expect do
  #      Micropost.new(user_id: user.id)
  #    end.to raise_error
  #  end
  #end
  #
  describe "with blank content" do
    before { @micropost.content = "" }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @micropost.content = "a" * 141 }
    it { should_not be_valid }
  end
end
