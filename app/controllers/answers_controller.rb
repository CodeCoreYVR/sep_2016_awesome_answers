class AnswersController < ApplicationController
  before_action :authenticate_user

  def create
    @question        = Question.find params[:question_id]
    answer_params    = params.require(:answer).permit(:body)
    @answer          = Answer.new answer_params
    @answer.question = @question
    @answer.user     = current_user
    if @answer.save
      redirect_to question_path(@question), notice: 'Answer created!'
    else
      render 'questions/show'
    end
  end

  def destroy
    answer = Answer.find params[:id]
    question = answer.question
    answer.destroy
    redirect_to question_path(question), notice: 'Answer deleted!'
  end
end
