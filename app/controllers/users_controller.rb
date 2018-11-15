def UsersController < ApplicationController

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to new_session_url
    else
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def show
    render :show
  end

  def user_params
    params.require(:users).permit(:email, :password)
  end
end
