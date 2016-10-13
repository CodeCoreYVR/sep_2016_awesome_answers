Rails.application.routes.draw do
  # this means when we receive a GET request with `/` url we invoke the index
  # action within the Home Controller
  get '/' => 'home#index', as: :home
  # root 'home#index'


  resources :questions
  # the url helpers (when we set it using `as`) is only concerned about the
  # URL and not the VERB. So even if we have two routes with the same url
  # and different verbs, the url helper should be the same.
  # get({'/questions/new' => 'questions#new', as: :new_question})
  # post({'/questions'    => 'questions#create', as: :questions})
  # get '/questions/:id'  => 'questions#show', as: :question
  # get '/questions'      => 'questions#index'
  # get '/questions/:id/edit' => 'questions#edit', as: :edit_question
  # patch '/questions/:id'    => 'questions#update'
  # delete '/questions/:id'   => 'questions#destroy'


  get '/contact' => 'home#contact' # Rails auto-generate a URL helper called
                                   # contact_path (and contact_url)

  post '/contact_submit' => 'home#contact_submit'
end
