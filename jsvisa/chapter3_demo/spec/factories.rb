FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "123456"
    password_confirmation "123456"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Hello world"
    user
  end
end
