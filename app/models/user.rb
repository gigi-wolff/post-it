class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  
  #add gem 'bcrypt-ruby', '=3.0.1' to gemfile to use has_secure_password method
  #set validations to false to manage validations ourselves 
  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  #"on: :create" means password must be present whenever a user object is created
  #therefore this condition will not be invoked for updates of existing user object
  validates :password, presence: true, on: :create, on: :update, length: {minimum: 6}
end
