class Post < ActiveRecord::Base
  validates :title, :description, presence: true
  has_and_belongs_to_many :tags
  belongs_to :user
end
