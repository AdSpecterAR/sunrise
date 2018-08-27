FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { first_name + last_name }
    email { Faker::Internet.email }
    password { 'password1' }

    # Test customer on our Stripe account, tied to
    # the #stripe_plan_id on the Plan factory.
    # Don't change unless we change the test
    # value on the account.
    stripe_customer_id 'cus_DHSG4kXuZRItnC'
  end

  trait :instructor do
    instructor true
  end

  trait :student do
    instructor false
    admin true
  end

  trait :admin do
    admin true
  end

  trait :new do
    id nil
  end
end
