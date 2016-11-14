class Api::V1::QuestionsController < Api::BaseController

  def index
    @questions = Question.order(created_at: :desc).limit(10)
    # render json: @questions.to_json

    # this will render views/api/v1/questions/index.json.jbuilder
  end

  def show
    question = Question.find params[:id]
    # serialization = ActiveModelSerializers::SerializableResource.new(question)
    # json_string   = serialization.to_json
    # render json: json_string
    render json: question
  end

  def create
    question_params = params.require(:question).permit(:title, :body)
    question        = Question.new question_params
    question.user   = @api_user
    if question.save
      render json: { id: question.id, status: :success }
    else
      render json: { status: :failure, errors: question.errors.full_messages }
    end
  end

end
