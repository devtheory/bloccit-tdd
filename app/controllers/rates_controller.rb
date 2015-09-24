class RatesController < ApplicationController
  def show
    @rate = Rate.find(params[:id])
  end
end
