class UsersController < ApplicationController

  def register
    @user = User.new(signup_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'signup'
    end
  end

  def signup
    @user = User.new
  end

  def create_user_session
    @user = User.find_by(email: signin_params[:email])
    if @user && @user.valid_password?(signin_params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'signin'
    end
  end

  def signin
    @user = User.new
  end

  def signout
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def signup_params
    params.require(:user).permit(:email, :password, :name, :password_confirmation).merge(role:0)
  end

  def signin_params
    params.permit(:email, :password)
  end
end
