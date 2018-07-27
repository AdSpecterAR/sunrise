FactoryBot.define do
  factory :course do
   # name { Faker::Name.first_name }
    name 'Yoga w Jess'
    duration 30
    category Course::VALID_CATEGORIES.sample
    difficulty Course::VALID_DIFFICULTIES.sample
    description 'stretch with jess!'
    equipment 'yoga mat'
  end
end
