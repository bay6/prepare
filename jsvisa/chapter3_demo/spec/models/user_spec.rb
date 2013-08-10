require 'spec_helper'

describe User do
  #pending "add some examples to (or delete) #{__FILE__}"
  before do
    @user = User.new(name: "Jsvisa", 
                     email: "delweng@gmail.com",
                     password: "foobarbaz",
                     password_confirmation: "foobarbaz") 
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:save) }
  it { should respond_to(:admin) }
  it { should respond_to(:microposts) }

  it { should be_valid }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

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
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar..com foo@bar+baz.com]
      #addresses = %w[user@foo..com]
      addresses.each do |invalid_address|
        #before { @user.email = invalid_address }
        #before do
        #  puts invalid_address
        @user.email = invalid_address
        #puts "user.email = #{@user.email}"
        expect(@user).to be_invalid
      end
    end
  end

  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", 
                       email: "user@example.com",
                       password: " ",
                       password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "save email with mixed case" do
    let(:mixed_email) { "HaHa@gMail.com" }
    before do
      @user.email = mixed_email
      @user.save
      expect(@user.reload.email).to eq mixed_email.downcase
    end
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "password is too short" do
    before { @user.password = @user.password_confirmation = "a"*5 }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    it { should eq found_user.authenticate(@user.password) }

    let(:user_for_invalid_password) { found_user.authenticate("Invalid") }
    it { should_not eq user_for_invalid_password }
    specify { expect(user_for_invalid_password).to be_false }
  end

  describe "remember_token should not empty" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "micropost associations" do

    before { @user.save }
    let!(:older_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right microposts in the right order" do
      expect(@user.microposts.to_a).to eq [newer_micropost, older_micropost]
    end

    it "should destroy all associated microposts after user destroyed" do
      microposts = @user.microposts.to_a
      @user.destroy
      expect(microposts).not_to be_empty
      microposts.each do |micropost|
        expect(Micropost.where(id: micropost.id)).to be_empty
      end
    end
  end
end

