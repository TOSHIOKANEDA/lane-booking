class SlotsController < ApplicationController
  
  def edit
    @slot = Slot.find(params[:id])
  end
  
  def show
    @slot = Slot.find(params[:id])
  end
  
  def update
    @slot = Slot.find_by(id: params[:id])
    @slot.update(slot_params)
    redirect_to orders_authority_path
  end
  
  private
  
  def slot_params
    params.permit(:begin_time, :end_time, :max_num)
  end
  
end
