class Post < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  scope :mine, ->(user) { where( posts: { user_id: user.id } ) }

  validates :project_id, presence: true
  validates :content,    presence: true
end
