class Api::V1::DishesController < Api::V1::BaseController
  def index
    @dishes = Dish.all
  end
end
