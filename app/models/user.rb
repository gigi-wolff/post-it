class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes
  
  #add gem 'bcrypt-ruby', '=3.0.1' to gemfile to use has_secure_password method
  #set validations to false to manage validations ourselves 
  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  #"on: :create" means password must be present whenever a user object is created
  #therefore this condition will not be invoked for updates of existing user object
  validates :password, presence: true, on: :create, length: {minimum: 6}
 
  sluggable_column :username

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator?'
  end

end