FactoryGirl.define do
	factory :user do
		sequence(:name) { |n| "Good#{n}" }
		sequence(:email) { |n| "good#{n}@gmail.com" }
		password "goodruby"
		password_confirmation "goodruby"

		factory :admin do
			admin true
		end
	end

	factory :micropost do
		content "Lorem ipum"
		user
	end
end