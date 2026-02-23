class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  belongs_to :user

  has_one_attached :image

  # 空の投稿を保存できない
  validates :image,                  presence: true
  validates :name,                   presence: true
  validates :info,                   presence: true
  validates :price,                  presence: true

  # ジャンルの選択が「---」の時は保存できないようにする
  validates :category_id,            numericality: { other_than: 1, message: "can't be blank" }
  validates :sales_status_id,        numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_fee_status_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id,          numericality: { other_than: 1, message: "can't be blank" }
  validates :scheduled_delivery_id,  numericality: { other_than: 1, message: "can't be blank" }

  # 価格の範囲（¥300〜¥9,999,999）と半角数値のバリデーション
  validates :price,
            numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                            message: 'is out of setting range' }
end
