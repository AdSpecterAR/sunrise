class Track < ApplicationRecord

  ### INCLUDES ###

  ### CONSTANTS ###


  ### ASSOCIATIONS ###

  has_many :posture_courses

  has_many :viewed_tracks
  has_many :users, through: :viewed_tracks


  ### SCOPES ###

  scope :active, -> { where(active: true) }


  ### VALIDATIONS ###

  validates :name, :image_url, :description, presence: true


  ### CALLBACKS ###


  ### CLASS METHODS ###


end
