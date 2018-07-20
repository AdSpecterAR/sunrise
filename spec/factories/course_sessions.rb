FactoryBot.define do
  factory :course_session do
    start_time { 2.hours.from_now }
    duration 45
    video_url "MyString"
    thumbnail_image_url "MyString"
  end
end
