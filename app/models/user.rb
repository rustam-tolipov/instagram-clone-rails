class User < ApplicationRecord
  has_many :posts, dependent: :destroy, foreign_key: 'user_id'
  has_many :comments, dependent: :destroy, foreign_key: 'user_id'
  has_many :likes, dependent: :destroy, foreign_key: 'user_id'

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users

  acts_as_voter

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  include ImageUploader.Attachment(:image)

  validates :name, presence: true, length: { maximum: 20 }
  validates :bio, length: { maximum: 200 }

  def self.suggest_users(user)
    user = users.reject { |u| following.include?(u) }.reject { |u| u == user }
  end

  def following?(user)
    followees.include?(user)
  end

  def followers_counter
    followers.count
  end
end
