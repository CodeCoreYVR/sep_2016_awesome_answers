json.array! @questions do |question|
  json.id question.id
  json.title question.title.upcase
  json.created_on question.created_at.strftime('%Y-%B-%d')
  json.answers_count question.answers.count
  json.user do
    json.first_name question.user_first_name
    json.last_name question.user_last_name
  end
  json.url api_v1_question_url(question)
end
