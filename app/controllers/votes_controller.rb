class VotesController < ApplicationController
  before_action :authenticate_user

  def create
    vote = Vote.new vote_params
    vote.user = current_user
    vote.question = question

    if vote.save
      redirect_to question_path(question), notice: "Vote!"
    else
      redirect_to question_path(question), alert: vote.error_description
    end
  end

  def destroy
    question = vote.question
    vote.destroy
    redirect_to question_path(question)
  end

  def update
    question = vote.question
    if vote.update vote_params
      redirect_to question_path(question)
    else
      redirect_to question_path(question), alert: vote.error_description
    end
  end

  private
  def vote_params
    params.require(:vote).permit(:is_up)
  end

  def question
    # ||= equivalent to
    # @question = @question || Question.friendly.find params[:question_id]
    @question ||= Question.friendly.find params[:question_id]
  end

  def vote
    @vote ||= Vote.find params[:id]
  end
end
