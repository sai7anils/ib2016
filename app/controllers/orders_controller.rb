class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @idea = Idea.find(params[:order][:idea_id].to_i)
    params_order = params.require(:order).permit(:idea_id, :ip_address, :first_name, :last_name, :card_type, :card_expires_on, :card_number, :card_verification)
    @order = @idea.build_order(params_order)
    @order.ip_address = request.remote_ip
    respond_to do |format|
      if @order.save
        if @order.purchase
          format.html { redirect_to user_business_ideas_path, notice: 'Idea was successfully created.' }
          format.json { render :show, status: :created, location: @idea }
        else
          format.html { redirect_to new_user_business_idea_path , notice: 'Idea was not successfully created, please check your payment.'}

          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to new_user_business_idea_path , notice: 'Idea was not successfully created, please check your payment.'}

        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:idea_id, :ip_address, :first_name, :last_name, :card_type, :card_expires_on, :card_number, :card_verification)
    end
end
