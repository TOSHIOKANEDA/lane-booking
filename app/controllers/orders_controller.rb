class OrdersController < ApplicationController
before_action :authenticate_user!
  
  def index
    @order = Order.new
  end
  
  def confirm
    @order = Order.new(order_params)
    render :action => 'confirm'
  end
  
  def done
     @order = Order.new(order_params)
      if params[:back]
      render :action => 'index'
      else
      @order.save
      render :action => 'done'
      end
  end
  
  def order_params
  params.require(:order).permit(:truck, :cntr_number, :date)
  end

end
