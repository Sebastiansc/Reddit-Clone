class PostsController < ApplicationController
  before_action :ensure_post_owner, only: [:edit, :update]

  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save!
      redirect_to post_url(@post)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @subs = Sub.all
    @author = @post.author
    @all_comments = @post.comments
    render :show
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << @post.errors.full_messages
      render :edit
    end
  end

  def ensure_post_owner
    @post = Post.find(params[:id])
    if current_user.id != @post.author_id
      redirect_to subs_url
    end
  end


  private
  def post_params
    params.require(:post).permit(:title, :content, :url, sub_ids: [])
  end
end
