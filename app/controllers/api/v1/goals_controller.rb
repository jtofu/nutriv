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
    @goal = Goal.new(goal_params)
    @goal.user = @user
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
    params.require(:user).permit(:amount, :unit, :user_id, :nutrient_id)
  end

  def render_error
    render json: { errors: @user.errors.full_messages },
    status: :unprocessable_entity
  end
end
