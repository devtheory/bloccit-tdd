class VotesController < ApplicationController
  before_action :require_sign_in

  def up_vote
    update_vote(1)
  end

  def down_vote
    update_vote(-1)
  end

  private

  def update_vote(new_value)
    @post = Post.find(params[:post_id])
    @vote = @post.votes.where(user: current_user).first

    if @vote
      @vote.update_attribute(:value, new_value)
    else
      @vote = current_user.votes.create(value: new_value, post: @post)
    end

    respond_to do |f|
      f.html
      f.js
    end
  end
end
