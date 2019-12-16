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
  
  def edit
  @order = Order.find(params[:id])
  end
  
  def update
    @order = Order.find_by(id: params[:id])
    @order.update(order_params)
    redirect_to controller: 'users', action: 'show'
  end
  
  def destroy
    @order = Order.find_by(id: params[:id])
    @order.destroy
    redirect_back(fallback_location: root_path)
  end
  
  def list
    redirect_to action: :index unless current_user.authority == 1
    if params[:t_range].present?
      @lists = Order.where(t_range: params[:t_range]).where(date: params[:date])
    else
      @lists = Order.none
    end
  end

  
  def done
     @order = Order.new(order_params)
     @order.user_id = current_user.id 
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