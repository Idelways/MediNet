class WelcomeController < ApplicationController
  def index
    user = User.first
    session[:user_id] = user.id
    redirect_to profil_path(user.id, user.slug)
  end
end
