class Course < ApplicationRecord

  DIFFICULTY_BEGINNER = 'beginner'
  DIFFICULTY_INTERMEDIATE = 'intermediate'
  DIFFICULTY_CHALLENGING = 'challenging'
  VALID_DIFFICULTIES = [
    DIFFICULTY_BEGINNER,
    DIFFICULTY_INTERMEDIATE,
    DIFFICULTY_CHALLENGING,
  ]
  CATEGORY_YOGA = 'yoga'
  CATEGORY_HIIT = 'hiit'
  CATEGORY_CARDIO = 'cardio'
  VALID_CATEGORIES = [
    CATEGORY_YOGA,
    CATEGORY_HIIT,
    CATEGORY_CARDIO,
  ]

  ### ASSOCIATIONS ###

  belongs_to :instructor, class_name: 'User'
  has_many :course_sessions

  ### VALIDATIONS ###

  # validate that instructor's instructor boolean is equal to True
  validates_associated :instructor

  validates :name, :duration, presence: true
  validates :difficulty, presence: true, inclusion:  { in: VALID_DIFFICULTIES }
  validates :category, presence: true, inclusion:  { in: VALID_CATEGORIES }

end
