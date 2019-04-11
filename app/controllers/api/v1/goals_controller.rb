class Api::V1::GoalsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: [:index, :create, :update]
  before_action :set_goal, only: [:show, :update, :destroy]

  def index
    @goals = @user.goals
  end

  def show
  end

  def create
    @nutrient = Nutrient.find_by(name: params[:nutrient])
    @goal = Goal.new(goal_params)
    @goal.user = @user
    @goal.nutrient = @nutrient
    if @goal.save
      render :show, status: :created
    else
      render_error
    end
  end


  def update
    if @goal.update
      render :show
    else
      render_error
    end
  end

  def destroy
    @goal.destroy
  end

  private

  def set_user
    @user = current_user
  end

  def set_goal
    @goal = Goal.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:amount, :user_id, :nutrient)
  end

  def render_error
    render json: { errors: @goal.errors.full_messages },
    status: :unprocessable_entity
  end
end
