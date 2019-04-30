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
  video_url: 'https://www.youtube.com/embed/LsBrT6vbQa8',
  thumbnail_image_url: '',
  course_id: yogaClass.id
)

CourseSession.create(
  start_time: 12.hours.from_now,
  duration: 45,
  video_url: 'https://www.youtube.com/embed/es2Ha1oKkgY',
  thumbnail_image_url: '',
  course_id: hiitClass.id
)

Plan.create(
  name: 'monthly subscription',
  stripe_plan_id: 'gold-special',
  interval: Plan::INTERVAL_MONTH
)

PostureCourse.create(
  name: 'Desk Stretch 1',
  duration: 10,
  category: 'desk',
  thumbnail_image_url: 'https://i.imgur.com/oJigReq.jpg',
  difficulty: 'beginner'
)

PostureCourse.create(
  name: 'Calves 1',
  duration: 5,
  category: 'stretching',
  thumbnail_image_url: 'https://i.imgur.com/64H0D8z.jpg',
  difficulty: 'beginner'
)

PostureCourse.create(
  name: 'Hamstrings 5',
  duration: 8,
  category: 'stretching',
  thumbnail_image_url: 'https://i.imgur.com/XntXG27.jpg',
  difficulty: 'intermediate'
)

PostureCourse.create(
  name: 'Activation - Plank',
  duration: 5,
  category: 'posture',
  thumbnail_image_url: 'https://i.imgur.com/zg6E2eU.jpg',
  difficulty: 'challenging'
)

Track.create(name: 'Posture for Relieving Back Pain', key: 'back_pain', description: 'This is the track to improve posture', image_url: 'https://i.imgur.com/XQfUKjD.png', onboarding_text: 'I want to alleviate back pain', onboarding_subtext: 'This track consists of spinal decompression exercises and lower body stretches.', onboarding_focus_text: 'to alleviate back pain', active: true)
Track.create(name: 'Posture for Desk Warriors', key: 'desk', description: 'This track will equip you with stretches you can do wherever you work. We focus on the neck, shoulders, chest, and back. You will also learn how to sit with proper posture.', image_url: 'https://i.imgur.com/XQfUKjD.png', onboarding_text: 'I work at a desk and feel sedentary', onboarding_subtext: 'This track consists of stretches and self-massage techniques you can do at your desk.', onboarding_focus_text: 'to not be sedentary when I work', active: true)
Track.create(name: 'Posture for Better Sleep and Reduced Stress', key: 'stress_and_sleep', description: 'This track will equip you to release tension you may be unaware of and calm your mind.', image_url: 'https://i.imgur.com/XQfUKjD.png', onboarding_text: 'I want to reduce stress and sleep better', onboarding_subtext: 'This track mixes in meditation with stretching and self-massage techniques.', onboarding_focus_text: 'to reduce stress and sleep better', active: true)
Track.create(name: 'Posture for Confidence', key: 'confidence', description: 'The stretches in this track will open up your chest and elongate your body from head to toe. You will feel a firm and effortless certainty about yourself.', image_url: 'https://i.imgur.com/XQfUKjD.png', onboarding_text: 'I want to look and feel more confident', onboarding_subtext: 'This track consists of chest, shoulder, & leg stretches to open and elongate your body.', onboarding_focus_text: 'to look and feel more confident', active: true)

PostureCourse.create(name: 'Self Massage', duration: 5, category: 'Foam Rolling 101', thumbnail_image_url: 'https://i.imgur.com/zg6E2eU.jpg', difficulty: 'intermediate', track_id: 2, active: false, video_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/4+-+Hamstrings+and+Calves+Intro.mp4')
PostureCourse.create(name: 'Deep Tissue with a Lacrosse Ball', duration: 5, category: 'Foam Rolling 101', difficulty: 'challenging', track_id: 2, active: false, thumbnail_image_url: 'https://i.imgur.com/zg6E2eU.jpg', video_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/4+-+Hamstrings+and+Calves+Intro.mp4')
PostureCourse.create(name: 'Reading in Bed', duration: 5, category: 'Posture', difficulty: 'beginner', track_id: 1, order_in_track: 4, active: true, thumbnail_image_url: 'https://i.imgur.com/GYFVO0m.png', video_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/4+-+Hamstrings+and+Calves+Intro.mp4')
PostureCourse.create(name: 'Confidence Boost', duration: 5, category: 'Office Break', difficulty: 'beginner', track_id: 2, active: true, thumbnail_image_url: 'https://i.imgur.com/WhiWKP9.png', video_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/4+-+Hamstrings+and+Calves+Intro.mp4')
PostureCourse.create(name: 'Shoulder Mobility', duration: 5, category: 'Office Break', difficulty: 'beginner', track_id: 2, active: false, thumbnail_image_url: 'https://i.imgur.com/WhiWKP9.png', video_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/4+-+Hamstrings+and+Calves+Intro.mp4')
PostureCourse.create(name: 'End of a Long Day', duration: 5, category: 'Goodbye Back Pain', difficulty: 'beginner', track_id: 2, active: true, thumbnail_image_url: 'https://i.imgur.com/WhiWKP9.png', video_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/4+-+Hamstrings+and+Calves+Intro.mp4')
PostureCourse.create(name: 'Lower Back Pain Relief', duration: 5, category: 'Goodbye Back Pain', difficulty: 'beginner', track_id: 2, active: true, thumbnail_image_url: 'https://i.imgur.com/WhiWKP9.png', video_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/4+-+Hamstrings+and+Calves+Intro.mp4')



# back pain track (id: 3)
PostureCourse.create(name: 'Day 1', duration: 8, order_in_track: 1, category: 'Desk Stretches', difficulty: 'beginner', track_id: 3, equipment: 'Desk', description: 'We will get a baseline of your posture in this first course and explain the importance of opening up the hamstring and calves first en route to better posture.', setup_instructions: 'You can do these stretches at your desk or using any tabletop.', active: true, thumbnail_image_url: 'https://i.imgur.com/WhiWKP9.png', video_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/posture+program+1_720_low.mp4')
# Jess sitting video: order in track #2
PostureCourse.create(name: 'Total Body Stretch', duration: 9, order_in_track: 3, category: 'Stretching', difficulty: 'beginner', track_id: 3, active: true, equipment: 'Strap', thumbnail_image_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/GIFs/Open+Chest+and+Longer+Legs.gif', video_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/posture+program+2+720+low.mp4')
PostureCourse.create(name: 'Foot Massage', duration: 8, order_in_track: 4, category: 'Foam Rolling 101', equipment: 'Massage or lacrosse ball', description: 'Believe it or not, tight calves and stiff ankles are often the cause of lower back pain. Rolling out the foot can release that tension. Plus, nothing feels quite as satisfying as a good foot massage!', difficulty: 'beginner', track_id: 3, setup_instructions: 'You can do this exercise seated on the floor, on a chair, or standing. You will feel it most intensely standing up and least intensely on the floor.', active: true, thumbnail_image_url: 'https://i.imgur.com/WhiWKP9.png', video_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/calves+ankle+feet.mp4')
PostureCourse.create(name: 'Countertop Stretches', duration: 6, order_in_track: 5, category: 'Desk Stretches', difficulty: 'beginner', track_id: 3, equipment: 'Desk', active: true, description: 'A few quick stretches you can do at your desk to alleviate lower back and neck strain from sitting too long.', setup_instructions: 'You can do these stretches at your desk or using any tabletop.', active: true, thumbnail_image_url: 'https://i.imgur.com/WhiWKP9.png', video_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/standing+desk+stretches.mp4')

# desk track (id: 4)
PostureCourse.create(name: 'Day 1', duration: 8, order_in_track: 1, category: 'Desk Stretches', equipment: 'Desk', description: 'A few quick stretches you can do at your desk to alleviate lower back and neck strain from sitting too long.', difficulty: 'beginner', track_id: 4, setup_instructions: 'You can do these stretches at your desk or using any tabletop.', active: true, thumbnail_image_url: 'https://i.imgur.com/WhiWKP9.png', video_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/posture+program+1_720_low.mp4')
PostureCourse.create(name: 'What Causes Back Pain When Sitting?', duration: 8, order_in_track: 1, category: 'Desk Stretches', equipment: 'Desk', description: 'A few quick stretches you can do at your desk to alleviate lower back and neck strain from sitting too long.', difficulty: 'beginner', track_id: 4, setup_instructions: 'You can do these stretches at your desk or using any tabletop.', active: true, thumbnail_image_url: 'https://i.imgur.com/WhiWKP9.png', video_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/posture+program+1_720_low.mp4')
# Jess sitting video: order in track #2
PostureCourse.create(name: 'Standing (Desk) Stretches', duration: 6, order_in_track: 3, category: 'Desk Stretches', equipment: 'Desk', description: 'A few quick stretches you can do at your desk to alleviate lower back and neck strain from sitting too long.', difficulty: 'beginner', track_id: 4, setup_instructions: 'You can do these stretches at your desk or using any tabletop.', active: true, thumbnail_image_url: 'https://i.imgur.com/WhiWKP9.png', video_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/standing+desk+stretches.mp4')
PostureCourse.create(name: 'Office Break', duration: 3, order_in_track: 4, category: 'Desk Stretches', difficulty: 'beginner', track_id: 4, active: true, thumbnail_image_url: 'https://i.imgur.com/WhiWKP9.png', video_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/energy+slump+should+pain.mp4')
PostureCourse.create(name: 'Foot Massage', duration: 8, order_in_track: 5, category: 'Foam Rolling 101', equipment: 'Massage or lacrosse ball', description: 'Nothing feels quite as satisfying as a good foot massage! Learn how to alleviate tight calves, ankles, or flat feet using a ball you can carry with you anywhere.', difficulty: 'beginner', track_id: 4, setup_instructions: 'You can do this exercise seated on the floor, on a chair, or standing. You will feel it most intensely standing up and least intensely on the floor.', active: true, thumbnail_image_url: 'https://i.imgur.com/WhiWKP9.png', video_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/calves+ankle+feet.mp4')

# sleep and stress track (id: 5)
PostureCourse.create(name: 'Foot Massage', duration: 8, order_in_track: 1, category: 'Foam Rolling 101', equipment: 'Massage or lacrosse ball', description: 'Nothing feels quite as satisfying as a good foot massage! Learn how to alleviate tight calves, ankles, or flat feet using a ball you can carry with you anywhere.', difficulty: 'beginner', track_id: 5, active: true, setup_instructions: 'You can do this exercise seated on the floor, on a chair, or standing. You will feel it most intensely standing up and least intensely on the floor.', thumbnail_image_url: 'https://i.imgur.com/WhiWKP9.png', video_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/calves+ankle+feet.mp4')

# confidence track (id: 6)
PostureCourse.create(name: 'Day 1', duration: 8, order_in_track: 1, category: 'Desk Stretches', difficulty: 'beginner', track_id: 6, equipment: 'Desk', description: 'We will get a baseline of your posture in this first course and explain the importance of opening up the hamstring and calves first en route to better posture.', setup_instructions: 'You can do these stretches at your desk or using any tabletop.', active: true, thumbnail_image_url: 'https://i.imgur.com/WhiWKP9.png', video_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/posture+program+1_720_low.mp4')
PostureCourse.create(name: 'Open Chest and Longer Legs', duration: 9, order_in_track: 2, category: 'Stretching', difficulty: 'beginner', track_id: 6, active: true, thumbnail_image_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/GIFs/Open+Chest+and+Longer+Legs.gif', video_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/posture+program+2+720+low.mp4')
PostureCourse.create(name: 'Confidence Boost', duration: 3, order_in_track: 3, category: 'Stretching', difficulty: 'beginner', track_id: 6, active: true, thumbnail_image_url: 'https://i.imgur.com/WhiWKP9.png', video_url: 'https://s3-us-west-1.amazonaws.com/cloudworkout/PostureApp/energy+slump+should+pain.mp4')
