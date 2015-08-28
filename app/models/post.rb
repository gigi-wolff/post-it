class Post < ActiveRecord::Base
  include Voteable
  include Sluggable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories


  #Callbacks are methods that get called at certain moments of an 
  #object's life cycle. With callbacks it is possible to write code
  #that will run whenever an Active Record object is created, saved,
  #updated, deleted, validated, or loaded from the database

  #this means we have to have a title whose length is at least 5 chars when creating a post
  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true

  sluggable_column :title
end