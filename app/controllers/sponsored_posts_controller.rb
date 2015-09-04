class SponsoredPostsController < ApplicationController
  def show
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = @topic.sponsored_posts.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = @topic.sponsored_posts.build(sponsored_post_params)

    if @sponsored_post.save
      redirect_to [@topic, @sponsored_post], notice: "Sponsored Post saved successfully!"
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = @topic.sponsored_posts.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = @topic.sponsored_posts.find(params[:id])

    if @sponsored_post.update_attributes(sponsored_post_params)
      redirect_to [@topic, @sponsored_post], notice: "Sponsored Post updated successfully"
    else
      flash[:error] = "Something went wrong"
      render :edit
    end
  end

  private

  def sponsored_post_params
    params.require(:sponsored_post).permit(:title, :body, :price)
  end
end
