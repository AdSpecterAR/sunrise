FactoryBot.define do
  factory :course do
    name 'Yoga with Jess'
    duration 30
    category Course::VALID_CATEGORIES.sample
    difficulty Course::VALID_DIFFICULTIES.sample
    description 'Stretch with Jess!'
    equipment 'Yoga mat'
  end
end
