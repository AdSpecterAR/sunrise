class PostureCourse < ApplicationRecord

  before_update :update_timestamps



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

  belongs_to :track, optional: true

  has_many :viewed_posture_courses
  has_many :users, through: :viewed_posture_courses


  ### VALIDATIONS ###

  validates :name, :duration, presence: true
  validates :difficulty, presence: true, inclusion:  { in: VALID_DIFFICULTIES }
  validates :category, presence: true, inclusion:  { in: VALID_CATEGORIES }


  ### SCOPES ###

  scope :active, -> { where(active: true) }
  scope :track, -> { where(course_type: 'track') }
  scope :explore, -> { where(course_type: 'explore') }
  scope :knowledge, -> { where(course_type: 'knowledge') }
  
  default_scope { order(order_in_track: :asc)} # What if order_in_track is null?


  ### INSTANCE METHODS ###

  def increment_total_favorite_count
    self.update(favorited_count: favorited_count + 1, last_favorited_at: Time.current)
  end

  def decrement_total_favorite_count
    return if favorited_count == 0

    self.decrement!(:favorited_count)
  end

  def increment_total_view_count
    self.increment!(:view_count)
  end

  def increment_total_completed_count
    self.increment!(:completed_count)
  end

  private

  def update_timestamps
    self.touch(:last_viewed_at) if view_count_changed?
    self.touch(:last_completed_at) if completed_count_changed?
  end
end
