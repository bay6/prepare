FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Pserson #{n}" }
    sequence(:email) { |n| "Pserson_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"
  end
end

