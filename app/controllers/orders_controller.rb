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
     limits = Order.where(t_range: @order.t_range, date: @order.date).count
     
      if params[:back]
      render :action => 'index'
      elsif limits < 2
      @order.save
      render :action => 'done'
      else
      flash[:notice] = "予約枠を超えています。時間帯を変えて入れなおしてください"
      redirect_to root_path
      end
  end

  
  private
  
  def order_params
  params.require(:order).permit(:truck, :cntr_number, :date, :t_range, :purpose)
  end

end

# 1=メール承認者
# 2=全時間帯
# 3=昼時間帯のみ
# 4=Test