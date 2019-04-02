FactoryBot.define do
  factory :streak do
  end

  trait :active do
    active true
    first_course_date { 5.days.ago }
    last_course_date { Time.current }
  end

  trait :ended do
    active false
    first_course_date { 5.days.ago }
    last_course_date { 3.days.ago }
  end

  trait :expiring do
    active true
    first_course_date { 5.days.ago }
    last_course_date { 3.days.ago }
  end

  trait :longest do
    active false
    first_course_date { 15.days.ago }
    last_course_date { 3.days.ago }
  end
end
