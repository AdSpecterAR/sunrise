FactoryBot.define do
  factory :course do
    name { Faker::Name.first_name }
    duration 30
    category Course::VALID_CATEGORIES.sample
    difficulty Course::VALID_DIFFICULTIES.sample
  end
end
