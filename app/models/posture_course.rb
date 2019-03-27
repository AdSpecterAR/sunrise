class PostureCourse < ApplicationRecord

  DIFFICULTY_BEGINNER = 'beginner'
  DIFFICULTY_INTERMEDIATE = 'intermediate'
  DIFFICULTY_CHALLENGING = 'challenging'
  VALID_DIFFICULTIES = [
    DIFFICULTY_BEGINNER,
    DIFFICULTY_INTERMEDIATE,
    DIFFICULTY_CHALLENGING,
  ]
  CATEGORY_POSTURE = 'Better Posture'
  CATEGORY_DESK = 'Desk Stretches'
  CATEGORY_OFFICE_BREAK = 'Office Break'
  CATEGORY_STRETCHING = 'Stretching'
  CATEGORY_FOAM_ROLLING = 'Foam Rolling 101'
  CATEGORY_NECK_PAIN = 'Goodbye Neck Pain'
  CATEGORY_BACK_PAIN = 'Goodbye Back Pain'

  VALID_CATEGORIES = [
    CATEGORY_POSTURE,
    CATEGORY_DESK,
    CATEGORY_OFFICE_BREAK,
    CATEGORY_STRETCHING,
    CATEGORY_FOAM_ROLLING,
    CATEGORY_NECK_PAIN,
    CATEGORY_BACK_PAIN,
  ]

  ### ASSOCIATIONS ###

  belongs_to :track

  has_many :viewed_posture_courses
  has_many :users, through: :viewed_posture_courses

  ### VALIDATIONS ###

  validates :name, :duration, presence: true
  # validates :order_in_track, presence: true, if: self.active
  validates :difficulty, presence: true, inclusion:  { in: VALID_DIFFICULTIES }
  validates :category, presence: true, inclusion:  { in: VALID_CATEGORIES }


  ### SCOPES ###

  scope :active, -> { where(active: true) }
end
