class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token
  before_action :set_user

  def show
    today = Date.today.to_date

    set_today_intake(today)
    last7d_intake(today)
    set_goals
  end

  def set_goals
    @goal_cal = 0
    @goal_protein = 0
    @goal_fat = 0
    @goal_carb = 0
    @goal_cholestrol = 0
    @goal_sat_fat = 0
    @goal_trans_fat = 0
    @goal_fiber = 0
    @goal_sodium = 0
    @goal_sugar = 0


    @goal_cal = @user.goals.find_by(nutrient: Nutrient.find_by(name: "Calories")).amount unless @user.goals.find_by(nutrient: Nutrient.find_by(name: "Calories")).nil?

    @goal_protein = @user.goals.find_by(nutrient: Nutrient.find_by(name: "Protein")).amount unless @user.goals.find_by(nutrient: Nutrient.find_by(name: "Protein")).nil?

    @goal_fat = @user.goals.find_by(nutrient: Nutrient.find_by(name: "Total Fat")).amount unless @user.goals.find_by(nutrient: Nutrient.find_by(name: "Total Fat")).nil?

    @goal_carb = @user.goals.find_by(nutrient: Nutrient.find_by(name: "Carbohydrate")).amount unless @user.goals.find_by(nutrient: Nutrient.find_by(name: "Carbohydrate")).nil?

    @goal_cholestrol = @user.goals.find_by(nutrient: Nutrient.find_by(name: "Cholestrol")).amount unless @user.goals.find_by(nutrient: Nutrient.find_by(name: "Cholestrol")).nil?

    @goal_sat_fat = @user.goals.find_by(nutrient: Nutrient.find_by(name: "Saturated Fat")).amount unless @user.goals.find_by(nutrient: Nutrient.find_by(name: "Saturated Fat")).nil?

    @goal_trans_fat = @user.goals.find_by(nutrient: Nutrient.find_by(name: "Trans Fatty Acid")).amount unless @user.goals.find_by(nutrient: Nutrient.find_by(name: "Trans Fatty Acid")).nil?

    @goal_fiber = @user.goals.find_by(nutrient: Nutrient.find_by(name: "Dietary Fiber")).amount unless @user.goals.find_by(nutrient: Nutrient.find_by(name: "Dietary Fiber")).nil?

    @goal_sodium = @user.goals.find_by(nutrient: Nutrient.find_by(name: "Sodium")).amount unless @user.goals.find_by(nutrient: Nutrient.find_by(name: "Sodium")).nil?

    @goal_sugar = @user.goals.find_by(nutrient: Nutrient.find_by(name: "Sugars")).amount unless @user.goals.find_by(nutrient: Nutrient.find_by(name: "Sugars")).nil?
  end

  def last7d_intake(today)
    @last7d_cal = []
    @last7d_protein = []
    @last7d_fat = []

    7.times do |n|
      day = 6 - n
      sum_cal = 0
      sum_protein = 0
      sum_fat = 0

      sum_date = today - day

      @user.meals.each do |meal|
        meal_date = meal.created_at.to_date

        sum_cal += (meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Calories")).amount * meal.quantity) if (meal_date == sum_date) && !(meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Calories")).nil?)
        sum_protein += (meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Protein")).amount * meal.quantity) if (meal_date == sum_date) && !(meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Protein")).nil?)
        sum_fat += (meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Total Fat")).amount * meal.quantity) if (meal_date == sum_date) && !(meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Total Fat")).nil?)
      end

      @last7d_cal << sum_cal
      @last7d_protein << sum_protein
      @last7d_fat << sum_fat
    end
  end

  def set_today_intake(today)
    @sum_cal = 0
    @sum_protein = 0
    @sum_fat = 0
    @sum_carb = 0
    @sum_cholestrol = 0
    @sum_sat_fat = 0
    @sum_trans_fat = 0
    @sum_fiber = 0
    @sum_sodium = 0
    @sum_sugar = 0

    @meals.each do |meal|
      if meal.created_at.to_date == today
        @sum_cal += (meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Calories")).amount * meal.quantity) unless meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Calories")).nil?
        @sum_protein += (meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Protein")).amount * meal.quantity) unless meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Protein")).nil?
        @sum_fat += (meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Total Fat")).amount * meal.quantity) unless meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Total Fat")).nil?
        @sum_carb += (meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Carbohydrate")).amount * meal.quantity) unless meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Carbohydrate")).nil?
        @sum_cholestrol += (meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Cholestrol")).amount * meal.quantity) unless meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Cholestrol")).nil?
        @sum_sat_fat += (meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Saturated Fat")).amount * meal.quantity) unless meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Saturated Fat")).nil?
        @sum_trans_fat += (meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Trans Fatty Acid")).amount * meal.quantity) unless meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Trans Fatty Acid")).nil?
        @sum_fiber += (meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Dietary Fiber")).amount * meal.quantity) unless meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Dietary Fiber")).nil?
        @sum_sodium += (meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Sodium")).amount * meal.quantity) unless meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Sodium")).nil?
        @sum_sugar += (meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Sugars")).amount * meal.quantity) unless meal.dish.doses.find_by(nutrient: Nutrient.find_by(name: "Sugars")).nil?
      end
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
    @meals = @user.meals # .order(created_at: :desc)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :profile_image, :username)
  end

  def render_error
    render json: { errors: @user.errors.full_messages },
    status: :unprocessable_entity
  end
end
