class Api::BaseController < ApplicationController
  # it's common to use `protect_from_forgery with: :null_session` when building
  # an API. This will make the session `nil` when the user doesn't send a valid
  # authenticity token which is expected when working with APIs. We should use
  # different technique for authenticating the user such as using an API key.
  protect_from_forgery with: :null_session
  before_action :authenticate

  private

  def authenticate
    @api_user = User.find_by_api_key params[:api_key]
    # render json: { status: 'invalid api key' } unless user
    head :unauthorized unless @api_user
  end

end
