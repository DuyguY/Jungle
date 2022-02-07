class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new(user_path)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end 

end