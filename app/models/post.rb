class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :likes, as: :likeable, :dependent => :destroy

  validates :title, presence: true, length: { in: 2..30 }
  validates :content, presence: true, length: { minimum: 3 }
end
