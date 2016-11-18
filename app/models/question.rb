class Question < ApplicationRecord
  attr_accessor :tweet_this

  belongs_to :user

  # This sets up the one to many association from the question model. You always
  # provide plural form of the model, in this case it's `answers`
  # this will give us handy methods to easily work with the association
  # you must provide a `dependent` option to your `has_many`
  # You can put `:destroy` if you'd like to delete all the answers associated
  # with a question when the question gets deleted.
  # You can also put `:nullify` which will update all the associated answers
  # to have a `question_id` of `NULL` when the question is deleted.
  has_many :answers, lambda { order(created_at: :DESC) }, dependent: :destroy

  validates :title, presence: true,
                    uniqueness: { case_sensitive: false,
                                  message: 'must be unique' }

  # with scope we validate that the combination of two fields is unique. In the
  # example below, we're validating that the combination of title/body is unique
  validates :body, length: { minimum: 5 },
                   uniqueness: { scope: :title }

  validates(:view_count, { numericality: { greater_than_or_equal_to: 0 } })

  validate :no_monkey

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  after_initialize :set_defaults
  before_validation :titleize_title

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  # the first argument `:image` in this case is the field in the DB to store the
  # image information
  # the second argument: ImageUploader is the class (created inside uploaders
  # folder) that conatain CarrierWave configuration for uploading our file
  mount_uploader :image, ImageUploader

  # def to_param
  #   # parameterize is a method from Rails that makes any string url friendly
  #   # by removing special characters and replacing spaces with dashes
  #   "#{id}-#{title}".parameterize
  # end

  # scope :recent_ten, lambda { limit(10).order(created_at: :desc) }
  def self.recent_ten
    limit(10).order(created_at: :desc)
  end

  def user_full_name
    if user
      user.full_name
    else
      'Anonymous'
    end
  end

  def user_first_name
    user ? user.first_name : 'Anonymous'
  end

  def user_last_name
    user ? user.last_name : 'Anonymous'
  end

  def like_for(user)
    likes.find_by(user: user)
  end

  def vote_value
    votes.up.count - votes.down.count
  end

  private

  def no_monkey
    if title && title.include?('monkey')
      errors.add(:title, 'No monkeys please!')
    end
  end

  def set_defaults
    self.view_count ||= 0
  end

  def titleize_title
    self.title = title.titleize if title.present?
  end
end
