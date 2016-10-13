class QuestionsController < ApplicationController
  # this action is to show the form for creating a new question
  # the URL: /questions/new
  # the path helper is: new_question_path
  def new
    @question = Question.new
  end

  # this action is to handle creating a new question after submitting the form
  # that was shown in the new action
  def create
    question_params = params.require(:question).permit([:title, :body])
    @question = Question.new question_params
    if @question.save
      # redirect_to question_path({id: @question.id})
      # redirect_to question_path({id: @question})
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  # this action is to show information about a specific question
  # URL: /questions/:id (for example /questions/123)
  # METHOD: GET
  def show
    @question = Question.find params[:id]
    # render plain: "In show action"
  end

  # this action is to show a listings of all the questions
  # URL: /questions
  # METHOD: GET
  def index
    @questions = Question.order(created_at: :desc)
  end

  # this action is to show a form pre-populated with the question's data
  # URL: /questions/:id/edit
  # METHOD: GET
  def edit
    @question = Question.find params[:id]
  end

  # this action is to capture the parameters from the form submission form the
  # edit action in order to update a question
  # URL: /questions/:id
  # METHOD: PATCH
  def update
    @question = Question.find params[:id]
    question_params = params.require(:question).permit(:title, :body)
    if @question.update question_params
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  # this action handles deleting a question
  # URL: /questions/:id
  # METHOD: DELETE
  def destroy
    @question = Question.find params[:id]
    @question.destroy
    redirect_to questions_path
  end
end
