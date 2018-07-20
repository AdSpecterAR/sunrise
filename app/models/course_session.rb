class CourseSession < ApplicationRecord

  ### ASSOCIATIONS ###

  belongs_to :course

  ### VALIDATIONS ###

  validates :start_time, presence: true

  class << self
    def courses_in_next_24_hours
      course_sessions = CourseSession
                          .where(start_time: 1.hour.ago..24.hours.from_now)
                          .sort_by { |course_session| course_session.start_time }

      course_sessions
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
end

