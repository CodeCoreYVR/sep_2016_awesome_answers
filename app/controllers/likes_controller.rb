class LikesController < ApplicationController
  before_action :authenticate_user

  def create
    question = Question.find params[:question_id]
    like = Like.new(user: current_user, question: question)

    if cannot? :like, question
      redirect_to :back, notice: "💢 Access Denied 💢"
    elsif like.save
      redirect_to :back, notice: "✨Thanks for liking✨"
    else
      redirect_to :back, alert: like.errors.full_messages.join(", ")
    end
  end

  def destroy
    like = Like.find params[:id]
    #question = like.question

    if like.destroy
      redirect_to :back, notice: "😭"
    else
      redirect_to :back, alert: like.errors.full_messages.join(", ")
    end
  end
end
