require 'spec_helper'

describe "UserPages" do
	# subject{page}

  describe "signup page" do
		before { visit signup_path }
    it "have the content 'Signup' " do
    	expect(page).to have_content("Signup Page")
    end
    it "have the title 'Signup' " do
    	expect(page).to have_title(full_title "Signup")
    end
  end

  describe "profile page" do
  	let(:user) {FactoryGirl.create(:user)}
		before { visit user_path(user) }
    # it { should have_content(user.name)}
    # it { should have_title(full_title user.name)}
    it "got right content  " do
    	expect(page).to have_content(user.name)
    end
    it "got right title " do
    	expect(page).to have_title(full_title user.name)
    end
  end

  describe "signup " do
  	describe "with valid information" do

	  	before do
	  		visit signup_path
	  		fill_in "Name", :with => 'good'
	  		fill_in 'Email', :with => 'good@gmail.com'
	  		fill_in 'Password', :with => 'goodruby'
	  		fill_in 'Confirmation', :with => 'goodruby'
	  	end
	  	let(:submit){'Create my account'}

	  	it "should create a new user" do
		  	expect{click_button submit}.to change(User,:count).by(1)
	  	end
	  	describe "after submisson" do
	  		before {click_button submit}
		  	it "will got info page of new user" do
		  		user = User.find_by(email: 'good@gmail.com')
		  		expect(page).to have_title(user.name)
		  		expect(page).to have_selector('div.alert.alert-success', text:'Weclome')
		  		expect(page).to have_link('Signout')
		  	end
		  end



  	end
  	describe "with invalid information" do
  		
	  	before do
	  		visit signup_path
	  		fill_in "Name", :with => ''
	  		fill_in 'Email', :with => ''
	  		fill_in 'Password', :with => ''
	  		fill_in 'Confirmation', :with => ''
	  	end
	  	let(:submit){'Create my account'}

	  	it "should create a new user" do
		  	expect{click_button submit}.not_to change(User,:count)
	  	end
	  	describe "after submisson" do
	  		before {click_button submit}
		  	it "will got errors message" do
		  		expect(page).to have_title("Signup")
		  		expect(page).to have_content('error')
		  	end

		  end

  	end

  end

  describe "update page" do
  	let(:user) {FactoryGirl.create(:user)}
  	before do
  		sign_in(user)	
  	 	visit edit_user_path(user)
  	end
  	it "have content 'Update your profile' " do
  		expect(page).to have_content("Update your profile")
  	end 
  	it "have title 'Edit user' " do
  		expect(page).to have_title("Edit user")
  	end 
  	it "have link change' " do
  		expect(page).to have_link('change', href:'http://gravatar.com/emails')
  	end 

  	describe "when with invalid information" do
  		before { click_button "Save changes"}
  		it "will got error" do
	   		expect(page).to have_content("error")
  		end
  	end

  	describe "when with valid information" do
  		before do
  			fill_in "Name", with: "newname"
  			fill_in "Email", with: user.email
  			fill_in "Password", with: user.password 
  			fill_in "Confirmation", with: user.password 
  			click_button "Save changes"
  		end
  		it "will got success" do
  			#Profile page
  			expect(page).to have_title("newname")
	   		expect(user.reload.name).to eq("newname")
	   		#success info
	   		expect(page).to have_selector("div.alert.alert-success")
	   		#signed in 
	   		expect(page).to have_link('Signout',href: signout_path)
  		end

  	end
  end

  describe "index page" do
    let(:user) {FactoryGirl.create(:user)}
    before do
      sign_in user
      FactoryGirl.create(:user,name:"goodme",email:"goodme@gmail.com")
      FactoryGirl.create(:user,name:"goodyou",email:"goodyou@gmail.com")
      visit users_path
    end
    it "have content 'All users'" do
      expect(page).to have_content("All users")
    end 
    it "have title 'All users' " do
      expect(page).to have_title("All users")
    end 
    it "list each user " do
      User.all.each do |user|
        expect(page).to have_selector('li',text:user.name)
      end
    end 

    describe "pagination" do
      before(:all){ 30.times {FactoryGirl.create(:user)}}
      after(:all){ User.delete_all }
      it "have selector pagination" do
        expect(page).to have_selector("div.pagination")
      end
      User.paginate(page: 1).each do |user|
        expect(page).to have_selector 'li', text: user.name
      end
    end

    describe "delete links" do
      it "have no delete link" do
        expect(page).not_to have_link('delete')
      end
      describe "as an admin user" do 
        let(:admin) {FactoryGirl.create(:admin)}
        before do
          sign_in admin
          visit users_path
        end
        it "have delete link" do
          expect(page).to have_link('delete', href: user_path(User.first))
        end
        it "should be able delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it "have no delete link by himself" do
          expect(page).not_to have_link('delete', href: user_path(admin))
        end
      end 
    end
  end

  describe "edit" do
    let(:user) {FactoryGirl.create(:user)}
    before do
      sign_in user,no_capbara:true
    end
    describe "forbidden attributes" do
      let(:params) do
        {user: {id: user.id, admin: true, password: user.password,
                password_confirmation: user.password }}
      end
      before { patch user_path(user), params}
      specify {expect(user.reload).not_to be_admin}
    end
  end

  describe "new and create" do
    describe "Users is aready signed in " do
      let(:user){FactoryGirl.create(:user)}

      describe "go new page" do
        before do
          sign_in user
          visit new_user_path
        end
        it "can not get there" do
          expect(page).not_to have_title('Signup')
        end
      end
      describe "go create action" do
        let(:params) do
          { user: {name:user.name,
                            email:user.email,
                            password:user.password,
                            password_confirmation:user.password}}
        end

        before do
          sign_in user,no_capbara:true
          post users_path,params
        end
        it "can not get there" do
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  describe "microposts " do
    let(:user) {FactoryGirl.create(:user)}
    let!(:m1){FactoryGirl.create(:micropost,user: user, content:"Good")}
    let!(:m2){FactoryGirl.create(:micropost,user: user, content:"Bad")}
    describe "in Profile page" do
      before do
        # sign_in user
        visit user_path(user)
      end
      it "have content 'Good'" do
        expect(page).to have_content(m1.content)
      end
      it "have content 'Bad'" do
        expect(page).to have_content(m2.content)
      end
      it "have the count of content" do
        expect(page).to have_content(user.microposts.count)
      end
      describe "created by other user" do
        let(:other_user){FactoryGirl.create(:user)}
        before do
          FactoryGirl.create(:micropost, user:other_user)
          sign_in user
          visit user_path(other_user)
        end
        it "have no 'delete link'" do
          expect(page).not_to have_link('delete')
        end
      end
    end
  end
end
