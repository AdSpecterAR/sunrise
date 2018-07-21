class UserCourseSession < ApplicationRecord

  ### ASSOCIATIONS ###
  belongs_to :student, class_name: 'User'
  belongs_to :course_session

  class << self
    def find_or_create_session(student, course_session)
      UserCourseSession
        .find_or_create_by(student: student, course_session: course_session)
    end
  end
end
