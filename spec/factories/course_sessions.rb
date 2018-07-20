FactoryBot.define do
  factory :course_session do
    start_time { 2.hours.from_now }
    duration 45
    video_url { Faker::Internet.url }
    thumbnail_image_url { Faker::Internet.url }
  end
end
