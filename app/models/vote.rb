class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :user_id, presence: true, uniqueness: { scope: :question_id }
  validates :question_id, presence: true
  # without using inclusion validation, presence would
  # take a false value has not present
  validates :is_up, inclusion: { in: [true, false]}

  def is_down?
    is_up == false
  end
end
