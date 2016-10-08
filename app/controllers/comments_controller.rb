class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @comment.post_id = params[:post_id]
    @comment.parent_id = params[:comment_id]
    render :new
  end

  def create
    post_id = Comment.find(comment_params[:parent_id]).post_id
    # comment_params[:post_id]||= post_id
    c = comment_params
    c[:post_id]=post_id
    @comment = Comment.new(c)
    @comment.author_id = current_user.id
    #
    # @comment.post_id ||= post_id
    if @comment.save!
      redirect_to post_url(post_id)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << @comment.errors.full_messages
      render :new
    end
  end

  def destroy

  end

  def edit

  end

  def update

  end

  def show
    @comment = Comment.find(params[:id])
    render :show
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_id)
  end
end
