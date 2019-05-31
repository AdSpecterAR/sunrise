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


  ### CLASS METHODS ###

  def favorite_course
    self.update(favorite: true)
    self.posture_course.increment_total_favorite_count
  end

  def unfavorite_courses
    self.update(favorite: false)
    self.posture_course.decrement_total_favorite_count
  end

  def view
    if view_count.nil?
      views = 0
    else
      views = view_count
    end

    self.update(view_count: views + 1, last_viewed_at: Time.current)
    self.posture_course.increment_total_view_count
  end

  def complete_course
    if completed_count.nil?
      completions = 0
    else
      completions = view_count
    end

    self.posture_course.increment_total_completed_count
    self.update(completed: true, completed_count: completions + 1, last_completed_at: Time.current)
  end
end
