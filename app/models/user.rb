class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 空の投稿を保存できない（presence: true）
  validates :nickname,        presence: true
  validates :birth_date,      presence: true
  validates :last_name,       presence: true
  validates :first_name,      presence: true
  validates :last_name_kana,  presence: true
  validates :first_name_kana, presence: true

  # パスワードは、半角英数字混合での入力が必須（deviseのデフォルトに追加）
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates :password, format: { with: VALID_PASSWORD_REGEX }

  # 全角（漢字・ひらがな・カタカナ）での入力が必須
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ } do
    validates :last_name
    validates :first_name
  end

  # 全角（カタカナ）での入力が必須
  with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/ } do
    validates :last_name_kana
    validates :first_name_kana
  end
end
