class Question < ApplicationRecord

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

  after_initialize :set_defaults
  before_validation :titleize_title

  # scope :recent_ten, lambda { limit(10).order(created_at: :desc) }
  def self.recent_ten
    limit(10).order(created_at: :desc)
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
