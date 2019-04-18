class Api::V1::DishesController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  def index
    if params[:search].nil? && params[:nutrient].nil?
      @dishes = Dish.all
    elsif !params[:search].nil?
      search = params[:search].downcase
      @dishes = Dish.where("LOWER(name) LIKE ?", "%#{search}%")
    else
      nutrient = params[:nutrient]
      amount = params[:amount]

      @dishes = Dish.includes(:nutrients).where(doses: { amount: (0..amount.to_i) }, nutrients: { name: nutrient }).first(5)
    end
  end

  def show
    @dish = Dish.find(params[:id])
  end
end
