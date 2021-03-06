class User < ApplicationRecord

  ### INCLUDES ###


  ### CONSTANTS ###

  REASON_TALLER = 'I want to stand taller'
  REASON_BACK_PAIN = 'I want to alleviate my back pain'
  REASON_DESK = 'I spend much of my day at a desk'
  REASON_LOOK_BETTER = 'I want look more confident'
  REASON_LIFT_HEAVY = 'I lift heavy things for my job'
  REASON_SLEEP = 'I want to sleep better'

  VALID_POSTURE_REASONS = [
    REASON_TALLER,
    REASON_BACK_PAIN,
    REASON_DESK,
    REASON_LOOK_BETTER,
    REASON_LIFT_HEAVY,
    REASON_SLEEP,
  ]

  ACTIVITY_LEVEL_LOW = 'low'
  ACTIVITY_LEVEL_MODERATE = 'moderate'
  ACTIVITY_LEVEL_HIGH = 'high'

  VALID_ACTIVITY_LEVELS = [
    ACTIVITY_LEVEL_LOW,
    ACTIVITY_LEVEL_MODERATE,
    ACTIVITY_LEVEL_HIGH
  ]


  ### ASSOCIATIONS ###

  has_one :plan
  has_one :current_track, class_name: 'ViewedTrack'

  has_many :viewed_tracks, :dependent => :destroy
  has_many :viewed_posture_courses, :dependent => :destroy
  has_many :streaks, :dependent => :destroy
  has_many :tracks, through: :viewed_tracks
  has_many :posture_courses, through: :viewed_posture_courses


  ### SCOPES ###


  ### VALIDATIONS ###

  validates :first_name, :last_name, presence: true
  validates :activity_level, inclusion: { in: VALID_ACTIVITY_LEVELS }, allow_blank: true
  validates_uniqueness_of :firebase_uid


  ### CALLBACKS ###

  after_initialize :init


  ### CLASS METHODS ###

  def self.from_token_payload payload
    payload['sub']
  end

  def self.fetch(uid)
    User.find_by(firebase_uid: uid)
  end

  ### INSTANCE_METHODS ###

  def init
    self.minutes_exercised ||= 0
    self.courses_completed_count ||= 0
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def current_streak
    self.streaks.active.first
  end

  def knowledge_courses
    PostureCourse.knowledge
  end

  def start_or_increment_streak
    if current_streak.present? && !current_streak.expired?
      current_streak.increment
      current_streak
    else
      self.streaks.create
    end
  end

  def longest_streak
    # TODO: GET MOST RECENT OR ALL MAX?

    streaks.max_by(&:length)
  end

  def favorite_courses
    viewed_posture_courses.favorited
  end

  def recent_courses
    viewed_posture_courses.completed
  end

  def valid_posture_reasons
    VALID_POSTURE_REASONS
  end

  def finish_onboarding(params)
    @current_track_id = params[:track_id]
    current_track = self.viewed_tracks.create(track_id: @current_track_id)

    self.update(current_track: current_track)
    self.update(params.except(:track_id))
  end

  def complete_course(course_id)
    @viewed_course = self.viewed_posture_courses.find_by(posture_course_id: course_id)
    @viewed_course.complete_course

    self.increment_minutes_and_courses(@viewed_course.posture_course.duration)
    self.start_or_increment_streak
  end

  def increment_minutes_and_courses(duration)
    self.update(minutes_exercised: minutes_exercised + duration, courses_completed_count: courses_completed_count + 1)
  end

  #returns customer id
  def find_or_create_stripe_customer(stripeToken)
    if self.stripe_customer_id.nil?
      #create new customer
      customer = Stripe::Customer.create(
                source: stripeToken,
                email: self.email
            )

      self.update(stripe_customer_id: customer.id)
      customer.id
            # save the customer id in user table
    else
      self.stripe_customer_id
    end
  end

  def find_or_create_viewed_course(course_id)
    # TODO: Add last_viewed_at and increment viewed_posture_course ???

    @viewed_posture_course = self
                              .viewed_posture_courses
                              .find_or_create_by(
                                user_id: self.id,
                                posture_course_id: course_id
                              )

    @viewed_posture_course.view
    @viewed_posture_course
  end

  def add_subscription(subscription_id)
    subscription = Stripe::Subscription.retrieve(subscription_id)
    plan = Plan.find_by(stripe_plan_id: subscription.plan.id)
    self.update(stripe_subscription_id: subscription_id)
    self.update(plan: plan)
  end

  # Response body: { stripe: Stripe_subscription_response }
  # cancel removes the subscription from the user table, but does not remove subsctiption on stripes end
  def cancel_subscription
    subscription = Stripe::Subscription.retrieve(stripe_subscription_id)

    transaction do
      subscription.delete(at_period_end: true)
      self.update(stripe_subscription_id: nil)
      self.plan.update(user_id: nil)
    end

    subscription
  end

  private


  # def downcase_email
  #   self.email = email.downcase if email.present?
  # end
  #
  # def password_valid
  #   # do not run validation if the password is not being set
  #   return unless instance_variable_defined?(:@password)
  #
  #   # password cannot be nil
  #   errors.add(:password, "cannot be empty") and return if password.nil?
  #
  #   # password has to be at least 8 characters long
  #   errors.add(:password, "must be at least 8 characters long") if password.length < 8
  #
  #   # password must contain at least one number
  #   errors.add(:password, "must contain at least one number") if password.gsub(/[^0-9 ]/i, '').length == 0
  #
  #   # password must contain at least one character
  #   errors.add(:password, "must contain at least one character") if password.gsub(/[^a-z ]/i, '').length == 0
  # end
  #
  # def email_presence
  #   if email.blank?
  #     errors.add(:email, "cannot be blank")
  #     return
  #   end
  #
  #   # NOTE: Underscore fails here and is valid - see http://stackoverflow.com/a/2183140/3162992
  #   if !(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i === email)
  #     errors.add(:email, "format incorrect")
  #     return
  #   end
  # end
  #
  # def unique_email
  #   # users = User.where("? = ANY (email)", email).where.not(id: id)
  #   users = []
  #   if users.count > 0
  #     errors.add(:email, "email not unique")
  #     return
  #   end
  # end
end
