require 'spec_helper'

describe User do
  #pending "add some examples to (or delete) #{__FILE__}"
  before { @user = User.new(name: "Jsvisa", email: "delweng@gmail.com") }
  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }

  it { should be_valid }

  describe "When name is empty" do
    before { @user.name = "" }
    it { should_not be_valid }
  end

  describe "When email is empty" do
    before { @user.email= "" }
    it { should_not be_valid }
  end

  describe "When name is too long" do
    before { @user.name= "A"*51 }
    it { should_not be_valid }
  end

  describe "When name is too short" do
    before { @user.name= "A" }
    it { should_not be_valid }
  end

  describe "Invalid email address" do
    addresses = %w[user@foo,com 
                  user_at_foo.org 
                  example.user@foo.
                  foo@bar_baz.com 
                  foo@bar+baz.com]
    addresses.each do |invalid_address|
      before { @user.email = invalid_address }
      it { should_not be_valid }
    end
  end
end

