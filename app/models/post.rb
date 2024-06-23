class Post < ApplicationRecord
  belongs_to :user
  
  has_many :comments, :dependent => :destroy
  has_many :likes, as: :likeable, :dependent => :destroy

  has_one_attached :image
  has_rich_text :content

  validates :title, presence: true, length: { in: 2..30 }
  validates :content, presence: true, length: { minimum: 3 }

  def image_as_thumbnail
    image.variant(resize_to_limit: [300, 300])
  end
end
