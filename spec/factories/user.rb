FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { first_name + last_name }
    # account_type { [User::ACCOUNT_TYPE_ADVERTISER, User::ACCOUNT_TYPE_DEVELOPER].sample }
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
