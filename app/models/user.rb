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
  validates :password, presence: true, on: :create, length: {minimum: 6}

  before_save :generate_slug

  def generate_slug
    the_slug = to_slug(self.username)
    user = User.find_by slug: the_slug
    count = 2
    while user && user != self
      the_slug = append_count(the_slug, count)
      user = User.find_by slug: the_slug
      count += 1
    end
    self.slug = the_slug.downcase
  end

  def append_count(str, count)
    if str.split('-').last.to_i != 0
      return str.split('-').slice(0...-1).join('-') + "-" + count.to_s
    else
      return str + "-" + count.to_s
    end
  end

  def to_slug(name)
    str = name.strip
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    str.gsub! /-+/,"-"
    str.downcase
  end



  def to_param
    self.slug
  end
 
end
