class Streak < ApplicationRecord

  ### ASSOCIATIONS ###

  belongs_to :user


  ### VALIDATIONS ###

  validates :first_course_date, :last_course_date, presence: true
  validates_inclusion_of :active, in: [true, false]


  ### SCOPES ###

  scope :active, -> { where(active: true) }

  ### CALLBACKS ###

  after_initialize :init

  ### METHODS ###

  class << self
    def close_expired_streaks
      Streak.active.each do |s|
        s.end if s.expired?
      end
    end
  end

  def init
    current_time = Time.current.to_date

    self.first_course_date ||= current_time
    self.last_course_date ||= current_time
    self.active = true if self.active.nil?
  end

  def expired?
    return true unless active

    days_in_date_range(Time.current, last_course_date) > 1
  end

  def increment
    return unless active
    return if already_incremented_today?

    self.update(last_course_date: Time.current)
  end

  def end
    self.update(active: false)
  end

  def length
    days_in_date_range(first_course_date, last_course_date)
  end

  def days_in_date_range(first_date, second_date)
    difference = (second_date.to_date - first_date.to_date).to_i

    if difference > 0
      difference + 1
    else
      (difference - 1) * -1
    end
  end

  def already_incremented_today?
    first_date = Time.current
    second_date = last_course_date

    days_in_date_range(first_date, second_date) == 1

    # current_day = Time.current.strftime('%d')
    # end_day = last_course_date.strftime('%d')
    #
    # # in case there's an error and last_course_date is in the future
    # days_ago = Time.current.to_date - last_course_date.to_date
    # return true if days_ago < 0
    #
    # current_day == end_day
  end
end