class OrdersController < ApplicationController
  protect_from_forgery :except => [:execute]
  before_action :set_order, only: [:show, :edit, :update, :destroy, :execute]
  before_action :authenticate_user!

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
    @order = Order.new(user: current_user)
  end

  # GET /orders/1/edit
  def edit
  end

  # GET /orders/1/execute
  def execute
    respond_to do |format|
      if @order.executed_payment?(params)
        format.html { redirect_to item_path(@order.orderable), flash: {success: 'Orden creada satisfactoriamente.'} }
        format.json { head :ok }
      else
        status = @order.paypal_errors ? { error: @order.paypal_errors } : { alert: "Orden cancelada." }
        format.html { redirect_to item_path(@order.orderable), flash: status }
        format.json { render json: status, status: :unprocessable_entity }
      end
    end
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.user = current_user

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order.approval_url }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { redirect_to item_path(@order.orderable), flash: {error: @order.errors.full_messages.join(". ") } }
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
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
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
      params.require(:order).permit(:user_id, :amount, :description, :orderable_id, :orderable_type)
    end
end