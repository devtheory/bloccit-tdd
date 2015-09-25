class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.new(comment_params)
    comment.user = current_user

    if comment.save
      flash[:notice] =  "Comment saved successfully"
    else
      flash[:error] = "Something went horribly wrong. Try again."
    end
    redirect_to [@post.topic, @post]
  end

  def destroy
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:id])

    if comment.destroy
      flash[:notice] = "Comment deleted successfully"
    else
      flash[:error] = "Something went wrong"
    end
    redirect_to [post.topic, post]
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:error] = "You don't have permission to do that"
      redirect_to [comment.post.topic, comment.post]
    end
  end
end
