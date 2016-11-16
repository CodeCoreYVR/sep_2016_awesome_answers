class AnswersMailer < ApplicationMailer

  def notify_question_owner(answer)
    @answer   = answer
    @question = answer.question
    @user     = @question.user
    if @user && @user.email
      mail(to: @user.email, subject: 'You got an answer to your question')
    end
  end
end
