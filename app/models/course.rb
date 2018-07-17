class Course < ApplicationRecord

  ### VALIDATIONS ###
  validates :name, :start_date, :duration, :category, :difficulty, presence: true
end
