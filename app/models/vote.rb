class Vote < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  
  # polymorphic: true tells rails to look for voteable type and id
  belongs_to :voteable, polymorphic: true

  # the same user cannot create a vote for the same object
  validates_uniqueness_of :creator, scope: [:voteable_id, :voteable_type]
end