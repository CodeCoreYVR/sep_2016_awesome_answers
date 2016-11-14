class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :user_full_name

  def user_full_name
    object.user_full_name
  end
end
