FactoryBot.define do
  factory :course do
    name { Faker::Name.first_name }
    start_date Time.current.tomorrow
    duration 30
    category Course::VALID_CATEGORIES.sample
    difficulty Course::VALID_DIFFICULTIES.sample
  end
end
