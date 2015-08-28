module Sluggable
  extend ActiveSupport::Concern

  included do
    #Active Record Callbacks, ie "before_save", are methods that get called at  
    #certain moments of anobject's life cycle. With callbacks it is possible 
    #to write codethat will run whenever an Active Record object is created, 
    #saved,updated, deleted, validated, or loaded from the database
    before_save :generate_slug!
    class_attribute :slug_column
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

  def generate_slug!
    the_slug = to_slug(self.send(self.class.slug_column.to_sym))
    obj = self.class.find_by slug: the_slug
    count = 2
    while obj && obj != self
      the_slug = append_suffix(the_slug, count)
      obj = self.class.find_by slug: the_slug
      count += 1
    end
    self.slug = the_slug.downcase
  end

  def append_suffix(str, count)
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

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end
end

