class Post < ActiveRecord::Base
  validates :title, :description, presence: true
  has_and_belongs_to_many :tags
  belongs_to :user

  def update_tags(tags)
    tags = tags.split(',')
    self.tags = []
    tags.each do |t|
      tag = Tag.find_or_create_by_name(t.strip)
      self.tags << tag
    end
  end
end
