class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :answers_count, :user

  has_many :answers

  def user
    { first_name: object.user_first_name, last_name: object.user_last_name }
  end

  def answers_count
    # object in this case refers to the `question` that we're serializing
    # by serializing here we mean generating a JSON string from the object
    object.answers.count
  end

end
