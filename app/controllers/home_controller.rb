class HomeController < ApplicationController
  # this method is called `action`
  def index
    # this will render views/home/index.html.erb and it will use
    # views/layouts/application.html.erb
    # render :index, layout: 'application'
    # the line above is the conventional default so we can do without it
  end

  def contact
  end

  def contact_submit
    @name = params[:full_name]
  end
end
