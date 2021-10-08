class User < ApplicationRecord
  authenticates_with_sorcery!

  mount_uploader :avatar, AvatarUploader
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_boards, through: :bookmarks, source: :board
  has_many :comments, dependent: :destroy
  has_many :boards, dependent: :destroy
  validates :password, length: {minimum: 3}, if: -> { new_record? || changes[:crypted_password]}
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password]}
  validates :password_confirmation, presence: true, if: -> {new_record? || changes[:crypted_password]}

  validates :email, uniqueness: true
  validates :email, presence:true
  validates :last_name, presence: true, length: {maximum: 255 }
  validates :first_name, presence: true, length:{ maximum: 255 }
  
  def own?(object)
    id == object.user_id
  end
  
  #お気に入りに追加
  def bookmark(board)
    bookmark_boards << board
  end

  #お気に入りを解除
  def unbookmark(board)
    bookmark_boards.delete(board)
  end
  
  #お気に入り登録しているかどうか判定するメソッド
  def bookmark?(board)
    bookmark_boards.include?(board)
  end
end
