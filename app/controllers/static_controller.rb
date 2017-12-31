class StaticController < ApplicationController
  skip_before_action :authorized, only: [:index]

  def index
    if logged_in?
      redirect_to user_path(current_user)
    end
  end
end
