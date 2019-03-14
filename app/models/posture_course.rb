class PostureCourse < ApplicationRecord

  DIFFICULTY_BEGINNER = 'beginner'
  DIFFICULTY_INTERMEDIATE = 'intermediate'
  DIFFICULTY_CHALLENGING = 'challenging'
  VALID_DIFFICULTIES = [
    DIFFICULTY_BEGINNER,
    DIFFICULTY_INTERMEDIATE,
    DIFFICULTY_CHALLENGING,
  ]
  CATEGORY_POSTURE = 'posture'
  CATEGORY_DESK = 'desk'
  CATEGORY_STRETCHING = 'stretching'
  VALID_CATEGORIES = [
    CATEGORY_POSTURE,
    CATEGORY_DESK,
    CATEGORY_STRETCHING,
  ]

  ### ASSOCIATIONS ###

  belongs_to :track_section

  ### VALIDATIONS ###

  validates :name, :duration, presence: true
  validates :difficulty, presence: true, inclusion:  { in: VALID_DIFFICULTIES }
  validates :category, presence: true, inclusion:  { in: VALID_CATEGORIES }

end
