class Api::V1::GoalsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  def index
    @user = current_user
    # @user = User.find(1)
    @goals = @user.goals
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def create
    @user = current_user
    @goal = Goal.new(goal_params)
    if @goal.save
      render :show, status: :created
    else
      render_error
    end
  end


  def update
    @goal = Goal.find(params[:id])
    if @goal.update
      render :show
    else
      render_error
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
  end

  def goal_params
    params.require(:user).permit(:amount, :unit, :user_id, :nutrient_id)
  end

  def render_error
    render json: { errors: @user.errors.full_messages },
    status: :unprocessable_entity
  end
end
