class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable 

  #Callbacks are methods that get called at certain moments of an 
  #object's life cycle. With callbacks it is possible to write code
  #that will run whenever an Active Record object is created, saved,
  #updated, deleted, validated, or loaded from the database

  #this means we have to have a title whose length is at least 5 chars when creating a post
  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true

  #Active Record Callbacks, ie "after_validation", are methods that get called at  
  #certain moments of anobject's life cycle. With callbacks it is possible 
  #to write codethat will run whenever an Active Record object is created, 
  #saved,updated, deleted, validated, or loaded from the database
  before_save :generate_slug

  def total_votes
    up_votes - down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end


  def generate_slug
    self.slug = self.title.gsub(' ','-').downcase
  end

  #to_param is called automatically when post object is passed to path.
  #in _post.erb the link to comments line:
  #link_to("#{post.comments.size} comments", post_path(post)) is really
  #post_path(post.to_param)
  #also must now change all Post.find(params[:id]) to 
  #Post.find_by(slug: params[:id]) where ever its used
  def to_param
    self.slug
  end
end