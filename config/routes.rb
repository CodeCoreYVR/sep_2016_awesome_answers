Rails.application.routes.draw do
  # this means when we receive a GET request with `/` url we invoke the index
  # action within the Home Controller
  get '/' => 'home#index', as: :home

  get '/contact' => 'home#contact' # Rails auto-generate a URL helper called
                                   # contact_path (and contact_url)

  post '/contact_submit' => 'home#contact_submit'
end
