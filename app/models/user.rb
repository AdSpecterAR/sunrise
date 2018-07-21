class User < ApplicationRecord
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ### INCLUDES ###

  ### CONSTANTS ###


  ### ASSOCIATIONS ###

  has_many :courses
  has_many :user_course_sessions
  has_many :course_sessions, through: :user_course_sessions

  ### SCOPES ###


  ### VALIDATIONS ###

  validates :first_name, :last_name, :email, presence: true
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

  def signed_in?
    user_signed_in?
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
