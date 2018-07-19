FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { first_name + last_name }
    email { Faker::Internet.email }
    password { 'password1' }
  end

  trait :instructor do
    instructor true
  end

  trait :admin do
    admin true
  end

  trait :new do
    id nil
  end
end
