FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"

    factory :admin do
      admin true
    end
  end

  sequence :email do |n|
    "person-#{n}@example.com"
  end

  factory :micropost do
    content "Foo bar"
    association :user
  end
end
