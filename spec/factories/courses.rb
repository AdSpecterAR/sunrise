FactoryBot.define do
  factory :course do
    name { Faker::String }
    start_date Time.1.day.from_now
    duration 30
    category Course::VALID_CATEGORIES.sample
    difficulty Course::VALID_DIFFICULTIES.sample
  end
end
