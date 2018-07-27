class CourseSession < ApplicationRecord

  ### ASSOCIATIONS ###

  belongs_to :course
  has_many :user_course_sessions
  has_many :students, through: :user_course_sessions

  ### VALIDATIONS ###

  validates :start_time, :duration, presence: true

  class << self
    def courses_in_next_24_hours
      CourseSession
        .where(start_time: 1.hour.ago..24.hours.from_now)
        .sort_by { |course_session| course_session.start_time }
    end
  end

  def duration
    duration = read_attribute(:duration)

    return duration if duration.present?

    course.duration
  end

  def instructor_full_name
    "#{course.instructor.first_name} #{course.instructor.last_name}"
  end

  def all_participants
    user_course_sessions = self.user_course_sessions
    user_course_sessions.map { |u| u.student_full_name }
  end
end

