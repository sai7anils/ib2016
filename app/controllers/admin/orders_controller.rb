class Admin::OrdersController < Admin::ApplicationController
  before_action :set_order, only: [:show, :destroy]

  def index
    @orders = Order.order(created_at: :desc).page(params[:page])
  end

  def show
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.json { render json: true }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end
end
