class Project < ActiveRecord::Base
  belongs_to :user

  scope :mine, ->(user) { where( projects: { user_id: user.id } ) }

  validates :name, presence: true
end
