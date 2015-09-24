class TopicsController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  before_action :authorize_user, except: [:index, :show]

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      @topic.labels = Label.update_labels(params[:topic][:labels]) unless params[:topic][:labels].nil?
      @topic.rates = Rate.update_rates(params[:topic][:rates]) unless params[:topic][:labels].nil?
      redirect_to @topic, notice: "Topic created successfully!"
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])

    if @topic.update_attributes(topic_params)
      @topic.labels = Label.update_labels(params[:topic][:labels]) unless params[:topic][:labels].nil?
      @topic.rates = Rate.update_rates(params[:topic][:rates]) unless params[:topic][:labels].nil?
      redirect_to @topic, notice: "Topic updated successfully!"
    else
      flash[:error] = "Something went wrong!"
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      redirect_to topics_path, notice: "Topic deleted successfully!"
    else
      flash[:error] = "Something went wrong!"
      render :show
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end

  def authorize_user
    unless current_user.admin?
      flash[:error] = "You must be an admin to do that"
      redirect_to topics_path
    end
  end
end
