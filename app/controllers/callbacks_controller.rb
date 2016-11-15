class CallbacksController < ApplicationController
  def twitter
    # STEP 1: search for a user with the given provider / uid
    twitter_data = request.env['omniauth.auth']
    user = User.find_from_oauth(twitter_data)

    # STEP 2: Create the user if the user is not found
    user ||= User.create_from_oauth(twitter_data)

    # STEP 3: Sign in the user
    session[:user_id] = user.id

    redirect_to root_path, notice: 'Thanks for signing in with Twitter!'
  end
end
