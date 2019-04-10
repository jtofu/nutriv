class Api::V1::MealsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  def index
    @user = current_user
    @meals = current_user.meals
  end

  def show
    @meal = Meal.find(params[:id])
  end

  def create
    @dish = Dish.find(params[:dish_id])
    # @dish = Dish.find(571)
    @user = current_user
    @meal = Meal.new(meal_params)
    @meal.user = @user
    @meal.dish = @dish
    @meal.save

    if @meal.save
      render :index, status: :created
    else
      render_error
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:quantity, :user_id, :dish_id)
  end
    # params.require(:booking).permit(:user_id, :start_time, :end_time, :total_price)

  def render_error
    render json: { errors: @meal.errors.full_messages },
    status: :unprocessable_entity
  end
end
