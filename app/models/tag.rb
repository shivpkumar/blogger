class Tag < ActiveRecord::Base
  validates :name, uniqueness: true
  has_and_belongs_to_many :posts
  before_save :tag_to_lowercase

  def self.stringify(tags)
    tags.inject('') { |str, tag| str += "#{tag.name}, "}.chop.chop
  end

  def self.arrayify(tags)
    tags.inject('') { |str, tag| str += "[#{tag.name}] "}
  end

  private

  def tag_to_lowercase
    self.name = self.name.downcase
  end
end
