class Post < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  include ImageUploader::Attachment(:image)
  has_many :comments, dependent: :destroy
  validates :content, presence: true, length: { maximum: 200 }
  after_save :update_post_count

  after_save :update_cached_votes_total

  acts_as_votable

  private

  def update_cached_votes_total
    update_column(:cached_votes_total, votes_for.size)
  end

  def update_post_count
    user.update_attribute(:posts_counter, user.posts.count)
  end
end
