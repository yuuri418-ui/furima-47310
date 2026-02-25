class OrderAddress
  include ActiveModel::Model
  # 保存したい全てのカラム（Order + Address）を扱えるようにする
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number

  # 1-4. バリデーションの記述
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :addresses
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }
  end

  # 1-5. データをテーブルに保存する処理
  def save
    # 購入情報を保存し、変数orderに代入
    order = Order.create(user_id: user_id, item_id: item_id)
    # 住所情報を保存（order_idには、今作った購入情報のidを指定）
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, addresses: addresses, building: building,
                   phone_number: phone_number, order_id: order.id)
  end
end
