class UserCourseSession < ApplicationRecord

  ### ASSOCIATIONS ###
  belongs_to :student, class_name: 'User'
  belongs_to :course_session
end
