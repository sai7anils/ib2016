class Admin::TransactionsController < Admin::ApplicationController
  before_action :set_transaction, only: [:show, :destroy]

  def index
    @transactions = OrderTransaction.order(created_at: :desc).page(params[:page])
  end

  def show
  end

  def destroy
    @transaction.destroy
    respond_to do |format|
      format.json { render json: true }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = OrderTransaction.find(params[:id])
    end
end
