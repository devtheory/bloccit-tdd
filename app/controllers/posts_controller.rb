class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)

    if @post.save
      redirect_to [@topic, @post], notice: "Post created successfully!"
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])

    if @post.update_attributes(post_params)
      redirect_to [@topic, @post], notice: "Post updated!"
    else
      flash[:error] = "Something went wrong"
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])

    if @post.destroy
      redirect_to @topic, notice: "Post deleted successfully!"
    else
      flash[:error] = "Post failed to delete"
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end