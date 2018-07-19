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

  ### VALIDATIONS ###
  validates :name, :start_date, :duration, presence: true
  validates :difficulty, presence: true, inclusion:  { in: VALID_DIFFICULTIES }
  validates :category, presence: true, inclusion:  { in: VALID_CATEGORIES }
end
