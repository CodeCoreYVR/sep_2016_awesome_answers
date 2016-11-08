class AnswersController < ApplicationController
  before_action :authenticate_user

  def create
    @question        = Question.find params[:question_id]
    answer_params    = params.require(:answer).permit(:body)
    @answer          = Answer.new answer_params
    @answer.question = @question
    @answer.user     = current_user

    # AJAX with Rails
    # 1. use remote: true (for forms or links)
    # 2. make sure to respond to the js format
    # 3. use jQuery (or plain js) to render partials in order to make the views
    #    look the way you want them to. This minimizes the amount of js you will
    #    have to write

    respond_to do |format|
      if @answer.save
        format.js { render :create_success }
        format.html do
          redirect_to question_path(@question), notice: 'Answer created!'
        end
      else
        format.js { render :create_failure }
        format.html { render 'questions/show' }
      end
    end
  end

  def destroy
    answer = Answer.find params[:id]
    if can? :delete, answer
      question = answer.question
      answer.destroy
      redirect_to question_path(question), notice: 'Answer deleted!'
    else
      redirect_to root_path, alert: 'access denied'
    end
  end

end
