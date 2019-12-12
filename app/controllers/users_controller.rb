class UsersController < ApplicationController
    
def show
  @user = current_user
  @orders = @user.orders.paginate(:page => params[:page], :per_page => 10)
end
    
end
