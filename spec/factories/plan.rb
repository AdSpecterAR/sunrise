FactoryBot.define do
  factory :plan do
    name 'Yoga package'
    interval Plan::INTERVAL_MONTH
    stripe_plan_id 'Monthly_Plan_1'
    available true
    active true
  end

  trait :unavailable do
    available false
  end

  trait :inactive do
    active false
    available false
  end
end
