class TrackSection < ApplicationRecord

  ### INCLUDES ###

  ### CONSTANTS ###


  ### ASSOCIATIONS ###

  has_many :posture_courses
  belongs_to :track


  ### SCOPES ###


  ### VALIDATIONS ###

  validates :name, :description, presence: true


  ### CALLBACKS ###


  ### CLASS METHODS ###

end
