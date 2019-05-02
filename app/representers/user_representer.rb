require 'representable/json'

class UserRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :first_name
  property :last_name
  property :full_name
  property :username
  property :email
  property :firebase_uid
  property :fb_user_id
  property :fb_account
  property :current_streak, decorator: StreakRepresenter, class: Streak
  property :longest_streak, decorator: StreakRepresenter, class: Streak
  property :minutes_exercised
  property :courses_completed_count
  property :age
  property :activity_level
  property :gender
  property :daily_notification_hour
  property :daily_notification_minute
  property :reason
  property :current_track, decorator: ViewedTrackRepresenter, class: ViewedTrack
  collection :valid_posture_reasons
  collection :knowledge_courses
  collection :streaks, decorator: StreakRepresenter, class: Streak
  collection :viewed_posture_courses, decorator: ViewedPostureCourseRepresenter, class: ViewedPostureCourse
  collection :favorite_courses, decorator: ViewedPostureCourseRepresenter, class: ViewedPostureCourse
  collection :recent_courses, decorator: ViewedPostureCourseRepresenter, class: ViewedPostureCourse
end
