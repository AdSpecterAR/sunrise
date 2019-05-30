class Track < ApplicationRecord

  ### INCLUDES ###

  ### CONSTANTS ###

  KEY_BACK_PAIN = 'back_pain'
  KEY_DESK = 'desk'
  KEY_STRESS_AND_SLEEP = 'stress_and_sleep'
  KEY_CONFIDENCE = 'confidence'

  VALID_KEYS = [
    KEY_BACK_PAIN,
    KEY_DESK,
    KEY_STRESS_AND_SLEEP,
    KEY_CONFIDENCE
  ]

  ### ASSOCIATIONS ###

  has_many :posture_courses

  has_many :viewed_tracks
  has_many :users, through: :viewed_tracks


  ### SCOPES ###

  scope :active, -> { where(active: true) }
  default_scope { order(id: :asc)}


  ### VALIDATIONS ###

  validates :name, :image_url, :description, presence: true
  # validates :key, inclusion: { in: VALID_KEYS }


  ### CALLBACKS ###


  ### CLASS METHODS ###

end
