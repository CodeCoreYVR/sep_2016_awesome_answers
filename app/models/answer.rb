class Answer < ApplicationRecord
  # having this belongs_to mehtod here enables us to have features for the
  # answer model that makes it easy to user in association with the question
  # model. The model you reference with `belongs_to` should be provided as
  # singular.
  # This assumes that you have an integer field called `question_id` in your
  # answers table
  belongs_to :question

  validates :body, presence: true, length: { minimum: 5 }
end
