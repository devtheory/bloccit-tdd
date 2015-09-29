class FavoritesController < ApplicationController
  before_action :require_sign_in

  def create
    post = Post.find(params[:post_id])

    favorite = current_user.favorites.build(post: post)

    if favorite.save
      flash[:notice] = "Post added to favorites!"
    else
      flash[:error] = "Post failed to favorite. Try again."
    end
    redirect_to [post.topic, post]
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find(params[:id])

    if favorite.destroy
      flash[:notice] = "Unfavorited"
    else
      flash[:error] = "Failed to delete favorite"
    end
    redirect_to [post.topic, post]
  end
end
