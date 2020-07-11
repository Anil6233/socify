class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable, only: :create
  respond_to :js

  def new
    # @post = Post.new
    # @user = User.find(params[:id])
    @comment = current_user.comments.new
    redirect_to posts_path(@comment)
  end

  def create
    @comment = @commentable.comments.new(comment_params) do |comment|
      comment.comment = params[:comment][:comment]
      comment.post_id = params[:commentable_id]
      comment.user_id = current_user.id
    end
    respond_to do |format|
      if @comment.save
        format.html { redirect_to posts_path, notice: 'comment was successfully created.' }
      else
        format.html { redirect_to posts_path, notice: 'comment  not was successfully created.'}
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment_id = params[:id]
    @comment.destroy
  end

  private
  def find_commentable
    @commentable_type = params[:commentable_type].classify
    @commentable = @commentable_type.constantize.find(params[:commentable_id])
  end

  def comment_params
    params.require(:comment).permit(:title, :comment)
  end

end
