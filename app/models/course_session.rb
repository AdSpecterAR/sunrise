class CourseSession < ApplicationRecord

  ### ASSOCIATIONS ###

  belongs_to :course

  ### VALIDATIONS ###

  validates :start_time, presence: true

  class << self
    def courses_in_next_24_hours
      CourseSession
          .where(
              start_time: 1.hour.ago .. 24.hours.from_now).sort_by { |course_session| course_session.start_time }

      CourseSession.where(start_time: 1.hour.ago .. 24.hours.from_now)
    end
  end

end
