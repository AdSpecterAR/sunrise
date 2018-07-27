class UserCourseSession < ApplicationRecord

  RATING_THUMBS_UP = 'thumbs_up'
  RATING_THUMBS_DOWN = 'thumbs_down'
  VALID_RATINGS = [
    RATING_THUMBS_DOWN,
    RATING_THUMBS_UP
  ]


  ### ASSOCIATIONS ###

  belongs_to :student, class_name: 'User'
  belongs_to :course_session


  ### VALIDATIONS ###

  validates :rating, inclusion: { in: VALID_RATINGS }, allow_blank: true


  class << self
    def find_or_create_session(student, course_session)
      UserCourseSession
        .find_or_create_by(student: student, course_session: course_session)
    end
  end

  def add_feedback(rating, comment)
    if VALID_RATINGS.include?(rating)
      self.rating = rating
    end
    self.comment = comment
  end

  def return_student_name
    @student = User.find_by_id(self.student_id)
    @student.full_name
  end

  def course_name
    course_session.course.name
  end

  def course_category
    course_session.course.category
  end

  def course_difficulty
    course_session.course.difficulty
  end

  def course_description
    course_session.course.description
  end

  def course_equipment
    course_session.course.equipment
  end

end
