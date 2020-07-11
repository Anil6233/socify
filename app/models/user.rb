class User < ApplicationRecord
  mount_uploader :cover, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable
  has_many :posts, :dependent => :delete_all
  has_many :comments, as: :commentable
  acts_as_follower
  acts_as_followable
  acts_as_voter
  acts_as_commentable

end
