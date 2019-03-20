class Track < ApplicationRecord

  ### INCLUDES ###

  ### CONSTANTS ###


  ### ASSOCIATIONS ###

  has_many :track_sections


  ### SCOPES ###
  scope :active, -> { where(active: true) }

  ### VALIDATIONS ###

  validates :name, :image_url, :description, presence: true


  ### CALLBACKS ###


  ### CLASS METHODS ###

end