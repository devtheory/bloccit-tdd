class User < ActiveRecord::Base
  before_save {self.email = email.downcase}
  before_save {self.role ||= :member}
  # before_save :format_name
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, length: {minimum: 1, maximum: 100}, presence: true
  validates :password, length: {minimum: 6}, presence: true
  validates :email,
            length: {minimum: 7, maximum: 100},
            format: {with: EMAIL_REGEX},
            uniqueness: {case_sensitive: false},
            presence: true

  has_secure_password

  enum role: [:member, :admin]

  def favorite_for(post)
    favorites.where(post: post).first
  end

  def self.avatar_url(user, size)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  def favorited_posts
    posts = []
    favorites.each do |favorite|
      posts << favorite.post
    end
    posts
  end

  # private

  # def format_name
  #   unless self.name.nil?
  #     self.name = self.name.split.each.map { |e| e.capitalize!}.join(" ")
  #   end
  # end
end