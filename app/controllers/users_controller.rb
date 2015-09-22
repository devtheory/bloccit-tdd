class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: "Welcome to Bloccit, #{@user.name}!"
    else
      flash[:error] = "There was an error creating your account. Please try again."
      render :new
    end
  end

  def confirm
    @user = User.new(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
