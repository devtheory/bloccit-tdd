class AdvertisementsController < ApplicationController
  def index
    @advertisements = Advertisement.all
  end

  def show
    @advertisement = Advertisement.find(params[:id])
  end

  def new
    @advertisement = Advertisement.new
  end

  def create
    @advertisement = Advertisement.new(advertisement_params)

    if @advertisement.save
      redirect_to @advertisement, notice: "Ad created!"
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end

  private

  def advertisement_params
    params.require(:advertisement).permit(:title, :copy, :price)
  end
end
