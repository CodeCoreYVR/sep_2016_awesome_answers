class User < ApplicationRecord
  # if you want to store a temporary value in an ActiveRecord object then you
  # can add an attr_accessor. This won't go to the database if there is no
  # matching column name in the database table.
  # attr_accessor :password, :password_confirmation

  # More info: http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
  # has_secure_password will take the `password` given to the user object and
  # it will generate `password_digest`. So you must have `password_digest`
  # column in your users table.
  has_secure_password

  before_validation :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: VALID_EMAIL_REGEX

  has_many :questions, dependent: :nullify
  has_many :answers, dependent: :nullify

  def full_name
    "#{first_name} #{last_name}".strip.squeeze(' ').titleize
  end

  private

  def downcase_email
    self.email.downcase! if email.present?
  end

end
