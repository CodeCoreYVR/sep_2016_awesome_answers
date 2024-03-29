class QuestionsController < ApplicationController
  # the `before_action` method in here registers a method (usually private)
  # to be executed just before controller actions. This happens within the same
  # request/response cycle which means if you define an instance variable it
  # will be available within the action.
  # You can optinally give options: `only` or `except` to restrict the actions
  # that this `before_action` method applies to.
  # before_action :find_question, except: [:index, :new, :create]
  # before_action(:find_question, {only: [:edit, :update, :destroy, :show]})
  before_action :authenticate_user, except: [:index, :show]
  before_action :find_question, only: [:edit, :update, :destroy, :show]

  # The before_action methods will be executed at the order that they get
  # defined with. This means the `authenticate_user` will be called before
  # the `authorize_access` method. This means that the user will be
  # authenticated when we're inside the `authorize_access` method so we don't
  # have to check for that.
  before_action :authorize_access, only: [:edit, :update, :destroy]



  # this action is to show the form for creating a new question
  # the URL: /questions/new
  # the path helper is: new_question_path
  def new
    @question = Question.new
  end

  # this action is to handle creating a new question after submitting the form
  # that was shown in the new action
  def create
    @question = Question.new question_params
    @question.user = current_user
    if @question.save
      if @question.tweet_this
        client = Twitter::REST::Client.new do |config|
          config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
          config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
          config.access_token        = current_user.oauth_token
          config.access_token_secret = current_user.oauth_secret
        end
        client.update @question.title
      end

      # redirect_to question_path({id: @question.id})
      # redirect_to question_path({id: @question})

      # flash works very similar to the session in a sense that it uses cookies
      # to store values that persist through redirect_to or render
      # flash will clear the value as soon as it's read so it doesn't persist
      # through the rest of the requests
      flash[:notice] = 'Question Created!'
      redirect_to question_path(@question)
    else
      # if we juse use flash[:alert] in here then the flash message will persist
      # to the next request as well. flash.now[:alert] will make it only show
      # when you render the `:new` template but it won't persist to the next
      # request
      flash.now[:alert] = 'Please see errors below'
      render :new
    end
  end

  # this action is to show information about a specific question
  # URL: /questions/:id (for example /questions/123)
  # METHOD: GET
  def show
    @answer = Answer.new
    @like = @question.like_for(current_user)
    # render plain: "In show action"

    respond_to do |format|
      format.html { render }
      format.text { render }
      format.xml  { render xml: @question }
      format.json { render json: @question.to_json }
    end
  end

  # this action is to show a listings of all the questions
  # URL: /questions
  # METHOD: GET
  def index
    @questions = Question.order(created_at: :desc)
    respond_to do |format|
      format.html { render }
      format.text { render }
      format.xml  { render xml: @questions }
      format.json { render json: @questions.to_json }
    end
  end

  # this action is to show a form pre-populated with the question's data
  # URL: /questions/:id/edit
  # METHOD: GET
  def edit
  end

  # this action is to capture the parameters from the form submission form the
  # edit action in order to update a question
  # URL: /questions/:id
  # METHOD: PATCH
  def update
    # if we want to have friendly id update our slug we have to set it it nil
    @question.slug = nil
    if @question.update question_params
      flash[:notice] = 'Question updated'
      redirect_to question_path(@question)
    else
      flash.now[:alert] = 'Please see errors below!'
      render :edit
    end
  end

  # this action handles deleting a question
  # URL: /questions/:id
  # METHOD: DELETE
  def destroy
    @question.destroy
    # adding `notice: 'Question deleted'` to the redirect_to line will set a
    # flash notice message as we did the create / update actions
    # note that this only works for redirect and not for render
    redirect_to questions_path, notice: 'Question deleted'
  end

  private

  def question_params
    params.require(:question).permit([:title,
                                      :body,
                                      :tweet_this,
                                      :image,
                                      tag_ids: []])
  end

  def find_question
    @question = Question.friendly.find params[:id]
  end

  def authorize_access
    unless can? :manage, @question
      # head :unauthorized # this will send an empty HTTP response with 401 code
      redirect_to root_path, alert: 'access denied'
    end
  end
end
