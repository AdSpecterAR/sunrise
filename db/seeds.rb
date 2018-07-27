# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
  first_name: 'John',
  last_name: 'Wooden',
  username: 'JohnWooden',
  email: 'JohnWooden@ucla.edu',
  password: 'uclanumberoneuc'
)

jessica = User.create(
  first_name: 'Jessica',
  last_name: 'Zhang',
  username: 'JessicaZhang',
  email: 'JessicaZhang@gmail.com',
  password: 'jessicaspassword',
  instructor: true
)

yogaClass = Course.create(
  name: 'Yoga with Jess',
  duration: 45,
  category: 'yoga',
  difficulty: 'beginner',
  instructor_id: jessica.id,
  description: 'Stretch with Jess!',
  equipment: 'yoga mat'
)

hiitClass = Course.create(
  name: 'HIIT with Jess',
  duration: 30,
  category: 'hiit',
  difficulty: 'intermediate',
  instructor_id: jessica.id,
  description: 'Sweat with Jess!',
  equipment: 'A good attitude!'
)

CourseSession.create(
  start_time: 2.days.from_now,
  duration: 30,
  video_url: 'https://www.youtube.com/watch?v=FiPkYIH1vnw',
  thumbnail_image_url: '',
  course_id: yogaClass.id
)

CourseSession.create(
  start_time: 1.day.from_now,
  duration: 45,
  video_url: 'https://www.youtube.com/watch?v=FiPkYIH1vnw',
  thumbnail_image_url: '',
  course_id: hiitClass.id
)

Plan.create(
    name: 'monthly subscription',
    stripe_plan_id: 'gold-special',
    interval: Plan::INTERVAL_MONTH
)
