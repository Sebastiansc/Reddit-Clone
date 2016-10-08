class SubsController < ApplicationController

  before_action :ensure_sub_ownership, only: [:edit, :update]

  def index
    @subs = Sub.all
    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save!
      redirect_to subs_url
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts
    render :show
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors]||=[]
      flash.now[:errors] << @sub.errors.full_messages
      render :edit
    end
  end

  def ensure_sub_ownership
    @sub = Sub.find(params[:id])
    if current_user.id != @sub.moderator_id
      redirect_to subs_url
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
