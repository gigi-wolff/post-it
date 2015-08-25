class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  
  #add gem 'bcrypt-ruby', '=3.0.1' to gemfile to use has_secure_password method
  #set validations to false to manage validations ourselves 
  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  #"on: :create" means password must be present whenever a user object is created
  #therefore this condition will not be invoked for updates of existing user object
  validates :password, presence: true, on: :create, on: :update, length: {minimum: 6}

  before_save :generate_slug

  def generate_slug
    self.slug = self.username.gsub(' ','-').downcase
  end

  def to_param
    self.slug
  end
 
end
