class UsersController < ApplicationController

  before_action :ensure_ownership, only: [:show]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save!
      login(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors]||=[]
      flash.now[:errors] << @user.errors.full_messages
      render :new
    end
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
