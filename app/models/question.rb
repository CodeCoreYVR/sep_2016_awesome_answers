class Question < ApplicationRecord
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
