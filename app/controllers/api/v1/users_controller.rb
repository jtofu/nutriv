class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token
  before_action :set_user

  def show
    @last7d_cal = []
    today = Date.today.to_date
    @sum_protein = 0
    @sum_fat = 0

    @user.meals.each do |meal|
      if meal.created_at.to_date == today
        @sum_protein += meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Protein")).amount
        @sum_fat += meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Total Fat")).amount
      end
    end

    7.times do |n|
      day = 6 - n
      sum_cal = 0

      sum_date = today - day

      @user.meals.each do |meal|
        meal_date = meal.created_at.to_date
        sum_cal += meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Calories")).amount if meal_date == sum_date
      end

      @last7d_cal << sum_cal
    end

    unless @user.goals.find_by(nutrient: Nutrient.find_by(name: "Calories")).nil?
      @goalCal = @user.goals.find_by(nutrient: Nutrient.find_by(name: "Calories")).amount
    else
      @goalCal = 0
    end

    unless @user.goals.find_by(nutrient: Nutrient.find_by(name: "Protein")).nil?
      @goalProtein = @user.goals.find_by(nutrient: Nutrient.find_by(name: "Protein")).amount
    else
      @goalProtein = 0
    end

    unless @user.goals.find_by(nutrient: Nutrient.find_by(name: "Total Fat")).nil?
      @goalFat = @user.goals.find_by(nutrient: Nutrient.find_by(name: "Total Fat")).amount
    else
      @goalFat = 0
    end
  end

  def update
    if @user.update(user_params)
      # render :show
    else
      render_error
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :profile_image, :username)
  end

  def render_error
    render json: { errors: @user.errors.full_messages },
    status: :unprocessable_entity
  end
end
