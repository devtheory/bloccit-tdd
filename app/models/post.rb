class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :topic
  belongs_to :user

  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings
  has_many :votes, dependent: :destroy

  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: {minimum: 20}, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  default_scope {order('created_at DESC')}

  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  def points
    votes.sum(:value)
  end
end
