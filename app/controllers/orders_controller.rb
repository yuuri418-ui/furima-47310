class OrdersController < ApplicationController
  before_action :authenticate_user! # ログイン必須
  before_action :set_item, only: [:index, :create]

  def index
    @order_address = OrderAddress.new # 手順2-6: 空のインスタンス
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    # paramsの中から配送先情報と、URLに含まれるitem_id、ログイン中のuser_idをまとめる
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
