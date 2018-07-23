class Plan < ApplicationRecord

  ### INCLUDES ###

  ### CONSTANTS ###


  # INTERVAL CONSTANTS MATCH STRIPE API'S INTERVALS.
  # ONLY CHANGE IF STRIPE API CHANGES
  INTERVAL_DAY = 'day'
  INTERVAL_WEEK = 'week'
  INTERVAL_MONTH = 'month'
  INTERVAL_YEAR = 'year'
  VALID_INTERVALS = [
    INTERVAL_DAY,
    INTERVAL_WEEK,
    INTERVAL_MONTH,
    INTERVAL_YEAR
  ]

  ### ASSOCIATIONS ###

  belongs_to :user

  ### SCOPES ###


  ### VALIDATIONS ###

  validates :name, :stripe_plan_id, :available, :active, presence: true
  validates :interval, inclusion: { in: VALID_INTERVALS }
  # validate: if plan updates to inactive, it should also be unavailable


  ### CALLBACKS ###


  ### CLASS METHODS ###


  ### INSTANCE_METHODS ###



  private

end
