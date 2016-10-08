class SessionsController < ApplicationController

  before_action :ensure_ownership, only: [:show]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params[:username],user_params[:password])
    if @user
      login(@user)
      redirect_to root_url
    else
      flash.now[:errors]||=[]
      flash.now[:errors] << "Unknown username/password combination"
      render :new
    end
  end

  def destroy
    logout!
    redirect_to root_url
  end

  def show
    @user = User.find(params[:id])
    if @user
      render :show
    else
      redirect_to root_url
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
