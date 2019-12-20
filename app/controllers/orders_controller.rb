class OrdersController < ApplicationController
before_action :authenticate_user!
before_action :set_params, only: [:done, :confirm]
before_action :authorized_user, only: [:authority, :list]


  def authority
    @users = User.paginate(page: params[:page], per_page: 10)
    @non_login_users = @users.reject{|user| user.id == current_user.id }
    @slots = Slot.all
  end
  
  def index
    @order = Order.new
    @slots = Slot.all
  end
  
  def confirm
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
    given = Order.where(date: params[:date]).where(slot_id: params[:slot_id])
    if given.present?
      @lists = given
    else
      flash[:notice] = "予約はありません。"
      redirect_to orders_authority_path
    end
  end
  
  
  def done
     @order.user_id = current_user.id
     limits = Order.where(slot_id: @order.slot_id, date: @order.date).count
      if params[:back]
      render :action => 'index'
      elsif limits < @order.slot.max_num.to_i
      @order.save!
      render :action => 'done'
      else
      flash[:notice] = "予約枠を超えています。時間帯を変えて入れなおしてください"
      redirect_to root_path
      end
  end

  
  private
  
  def order_params
    params.require(:order).permit(:truck, :cntr_number, :date, :purpose, :slot_id, :booking)
  end
  
  def set_params
    @order = Order.new(order_params)
  end
  
  def authorized_user
    redirect_to action: :index unless current_user.authority == 1
  end

end

# 1=メール承認者
# 2=全時間帯
# 3=昼時間帯のみ
# 4=Test