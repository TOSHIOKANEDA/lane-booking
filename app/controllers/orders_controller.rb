class OrdersController < ApplicationController
before_action :authenticate_user!

  def authority
  redirect_to action: :index unless current_user.authority == 1
  @users = User.paginate(page: params[:page], per_page: 10)
  @non_login_users = @users.reject{|user| user.id == current_user.id }
  
  end
  
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
  params.require(:order).permit(:truck, :cntr_number, :date, :t_range, :purpose)
  end

end

# 1=メール承認者
# 2=全時間帯
# 3=昼時間帯のみ