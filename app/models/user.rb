class User < ApplicationRecord
  scope :instructors, -> { where(instructor: true) }
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ### INCLUDES ###

  ### CONSTANTS ###


  ### ASSOCIATIONS ###

  has_one :plan

  has_many :courses
  has_many :user_course_sessions
  has_many :course_sessions, through: :user_course_sessions

  ### SCOPES ###


  ### VALIDATIONS ###

  validates :first_name, :last_name, presence: true
  validates :email, presence: true
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  # validate :password_valid
  # validate :email_presence
  # validate :unique_email


  ### CALLBACKS ###


  ### CLASS METHODS ###

  def self.from_token_payload payload
    payload['sub']
  end

  ### INSTANCE_METHODS ###

  def full_name
    "#{first_name} #{last_name}"
  end

  #returns customer id
  def find_or_create_stripe_customer(stripeToken)
    if self.stripe_customer_id.nil?
      #create new customer
      customer = Stripe::Customer.create(
                source: stripeToken
            )

      self.update(stripe_customer_id: customer.id)
      customer.id
            # save the customer id in user table
    else
      self.stripe_customer_id
    end
  end

  def add_subscription(subscription_id)
    subscription = Stripe::Subscription.retrieve(subscription_id)
    plan = Plan.find_by(stripe_plan_id: subscription.plan.id)
    self.update(stripe_subscription_id: subscription_id)
    self.update(plan: plan)
  end

#Response body: { stripe: Stripe_subscription_response }
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
