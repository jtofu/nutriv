class Api::V1::DishesController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  def index
    @dishes = Dish.all
  end

  def show
    @dish = Dish.find(params[:id])
  end
end
