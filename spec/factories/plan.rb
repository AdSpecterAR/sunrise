FactoryBot.define do
  factory :plan do
    name 'Yoga package'
    interval Plan::INTERVAL_MONTH
    available true
    active true

    # This test id value is saved to our Stripe
    # account, tied to the #stripe_customer_id
    # on the User factory. Don't change unless
    # we change the test value on the account
    stripe_plan_id 'gold-special'
  end

  trait :unavailable do
    available false
  end

  trait :inactive do
    active false
    available false
  end
end
