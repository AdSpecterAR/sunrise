class ViewedPostureCourse < ApplicationRecord

  ### INCLUDES ###

  ### CONSTANTS ###


  ### ASSOCIATIONS ###

  belongs_to :user
  belongs_to :posture_course


  ### SCOPES ###

  scope :favorited, -> { where(favorite: true) }
  scope :completed, -> { where(completed: true) }

  # default_scope { order(created_at: :desc)}

  ### VALIDATIONS ###


  ### CALLBACKS ###

  after_initialize :init

  ### CLASS METHODS ###

  def init
    self.view_count ||= 0
    self.favorite = false
    self.completed = false
    self.completed_count ||= 0
  end

  def favorite
    self.update(favorite: true)
    self.posture_course.increment_total_favorite_count
  end

  def unfavorite
    self.update(favorite: false)
    self.posture_course.decrement_total_favorite_count
  end

  def view
    self.update(view_count: view_count + 1, last_viewed_at: Time.current)
    self.posture_course.increment_total_view_count
  end

  def complete
    self.posture_course.increment_total_completed_count
    # self.update(completed: true, completed_count: completed_count + 1, last_completed_at: Time.current)
  end
end
