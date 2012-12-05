class Comment < ActiveRecord::Base
  belongs_to :lesson, :conditions => {:deleted => false}
  belongs_to :user, :conditions => {:deleted => false}
  belongs_to :parent_comment, :class_name => "Comment", :foreign_key => "parent_comment_id", :conditions => {:deleted => false}

  has_many :child_comments, :class_name => "Comment", :foreign_key => "parent_comment_id", :conditions => {:deleted => false}

  attr_accessible :lesson_id, :user_id, :content, :is_parent, :parent_comment_id, :deleted

  validates :content, :presence => true
  validates :content, :length => { :maximum => 1200 }
end
