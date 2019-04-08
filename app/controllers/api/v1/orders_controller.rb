class Api::V1::OrdersController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end
end
