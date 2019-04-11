class Api::V1::DishesController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  def index
    if params[:search].nil?
      @dishes = Dish.all
    else
      search = params[:search].downcase
      @dishes = Dish.where("LOWER(name) LIKE ?", "%#{search}%")
    end
  end

  def show
    @dish = Dish.find(params[:id])
  end
end
