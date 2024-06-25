class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_commit :add_default_profile_pic, on: [:create, :update]

  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :likes, :dependent => :destroy

  has_one_attached :image

  #follows relationships
  has_many :follows

  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following

  #validation
  validates :user_name, presence: true, uniqueness: true, length: { in: 2..30 }


  def profile_photo
    if image.attached?
      image.variant(resize_to_fill: [250, 250])
    else
      "/default_profile.jpg"
    end
  end

  private

  def add_default_profile_pic
    unless image.attached?
      image.attach(
        io: File.open(
          Rails.root.join(
          'app', 'assets', 'images', 'default_profile.png'
          )
        ),
        filename: 'default_profile.png',
        content_type: 'image/png'
        )
    end
  end

end

