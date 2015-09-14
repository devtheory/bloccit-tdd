class User < ActiveRecord::Base
  before_save {self.email = email.downcase}
  before_save :format_name

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, length: {minimum: 1, maximum: 100}, presence: true
  validates :password, length: {minimum: 6}, presence: true
  validates :email,
            length: {minimum: 7, maximum: 100},
            format: {with: EMAIL_REGEX},
            uniqueness: {case_sensitive: false},
            presence: true

  has_secure_password

  private

  def format_name
    unless self.name.nil?
      self.name = self.name.split.each.map { |e| e.capitalize!}.join(" ")
    end
  end
end