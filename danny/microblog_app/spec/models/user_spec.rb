require 'spec_helper'

describe User do

	before do
		@user = User.new(name: "good",
									    email: "good@gmail.com",
									    password:"goodruby",
									    password_confirmation: "goodruby")
	end

	subject { @user }
	#micropost
	it {should respond_to(:microposts)}

	it {should respond_to(:feed)}
	##admin
	it "respond to admin" do
		expect(subject).to respond_to(:admin)
	end
	describe "admin attribute is 'true' " do
		before do
			@user.save
			@user.toggle!(:admin)
		end
		it {should be_admin}
		
	end


###validations of name
	it "respond to name" do
		expect(subject).to respond_to(:name)
	end

	describe "when name is not present" do
		it "will be invalid" do
			@user.name = ""
			expect(subject).to be_invalid
		end
	end

	describe "when name is too long" do
		it "will be invalid" do
			@user.name = "a"*51
			expect(subject).to be_invalid
		end
	end

###validations of email
	it "respond to email" do
		expect(subject).to respond_to(:email)
	end
	describe "when email is not present" do
		it "will be invalid" do
			@user.email = ""
			expect(subject).to be_invalid
		end
	end

	describe "when email fromat is valid" do
		it "will be valid" do
			address = %w[user@foo.COM A_US-ER@f.b.org first.lst@foo.jp a+b@baz.cn]
			address.each do |valid_address|
				@user.email = valid_address
				expect(subject).to be_valid
			end
		end
	end

	describe "when email fromat is invalid" do
		it "will be invalid" do
			address = %w[user@foo,COM A_US-ER_at_f.b.org
			             first.lst@foo. foo@bar_baz.cn foo@bar_baz.cn]
			address.each do |invalid_address|
				@user.email = invalid_address
				expect(subject).to be_invalid
			end
		end
	end

	describe "when email address is already taken" do
		it "will be invalid" do
			user_with_same_email = @user.dup
			user_with_same_email.save
			expect(subject).to be_invalid
		end
	end

	##password
	it "resond to password_digest" do
		expect(subject).to respond_to(:password_digest)
	end

	it "resond to password" do
		expect(subject).to respond_to(:password)
	end
	it "resond to password_confirmation" do
		expect(subject).to respond_to(:password_confirmation)
	end

	describe "when password is too short" do
		it "will be invalid" do
			@user.password = "a" * 5
			@user.password_confirmation = "a" * 5
			expect(subject).to be_invalid
		end
	end

	describe "when password or confirmation is not present" do
		it "will be invalid" do
			@user.password = ""
			@user.password_confirmation = ""
			expect(subject).to be_invalid
		end
	end

	describe "when password does not match confirmation" do
		it "will be invalid" do
			@user.password_confirmation = "mismatch"
			expect(subject).to be_invalid
		end
	end

	###authenticate
	it "respond to authenticate" do
		expect(subject).to respond_to(:authenticate)
	end

	describe "return value of authenticate method" do
		before { @user.save }

    let(:user_got_valid_password) do
    	User.find_by(email: @user.email).authenticate(@user.password)
    end
    let(:user_got_invalid_password) do
    	User.find_by(email: @user.email).authenticate("invalid")
    end

		it "with valid password" do
			expect(@user).to eq user_got_valid_password
		end
		it "with invalid password" do
			expect(user_got_invalid_password).to be_false 
		end
	end

	it {should respond_to (:remember_token)}
	describe "remember token" do
		before {@user.save}
		its(:remember_token) { should_not be_blank }
	end


  describe "micropost associations" do
  	before { @user.save }
  	let!(:older_micropost) do
  		FactoryGirl.create(:micropost, user:@user,created_at: 1.day.ago)
  	end
  	let!(:newer_micropost) do
  		FactoryGirl.create(:micropost, user:@user,created_at: 1.hour.ago)
  	end
  	it "have the right order" do
  		expect(@user.microposts.to_a).to eq [newer_micropost, older_micropost]
  	end

  	it "destroy associated microposts" do
  		microposts = @user.microposts.to_a
  		@user.destroy
  		expect(microposts).not_to be_empty
  		microposts.each do |micropost|
  			expect(Micropost.where(id: micropost.id)).to be_empty
  		end
  	end


  	describe "status" do
  		let(:unfollowed_post) do
  			FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
  		end
  		let(:followed_user) { FactoryGirl.create(:user) }
  		before do
  			@user.follow!(followed_user)
  			3.times { followed_user.microposts.create!(content: "Lorem ipsum")}
  		end
  		it "feed have micropost created by himself" do
  			expect(@user.feed).to include(newer_micropost)
  			expect(@user.feed).to include(older_micropost)
  			expect(@user.feed).not_to include(unfollowed_post)
  			followed_user.microposts.each do |micropost|
  				expect(@user.feed).to include(micropost)
  			end
  		end
  	end

  end

  ##relationship
  it {should respond_to(:relationships)}
  it {should respond_to(:followed_users)}
  it {should respond_to(:reverse_relationships)}
  it {should respond_to(:fans)}
  ##method
  it {should respond_to(:follow!)}
  it {should respond_to(:unfollow!)}
  it {should respond_to(:following?)}

  describe "following" do
  	let(:other_user){FactoryGirl.create(:user)}
  	before do
  		@user.save
  		@user.follow!(other_user)
  	end
  	it {should be_following(other_user)}
  	its(:followed_users) {should include(other_user)}
  	describe "unfollow" do
  		before { @user.unfollow!(other_user) }
  		it {should_not be_following(other_user)}
  		its(:followed_users) {should_not include(other_user)}
  	end
  end

  describe "relationships associations" do
		let!(:user){FactoryGirl.create(:user)}
		let!(:followed){FactoryGirl.create(:user)}
		let!(:relationship){user.relationships.create!(followed_id: followed.id)}


  	it "destroy associated relationships" do
  		relationships = user.relationships.to_a
  		user.destroy!
  		expect(relationships).not_to be_empty
  		relationships.each do |relationship|
	  		expect(Relationship.where(id: relationship.id)).to be_empty
  		end

  	end
  end
end
