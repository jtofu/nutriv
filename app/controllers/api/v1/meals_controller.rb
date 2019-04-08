class Api::V1::MealsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  def index
    @meals = Meal.all
  end

  def create
    # @dish = ....
    # @user = current_user
    @meal = Meal.new()
  end
end
