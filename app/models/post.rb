class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  acts_as_votable

  mount_uploader :attachment, AvatarUploader
  include PublicActivity::Model
  # tracked only: [:create], owner: Proc.new{ |controller, model| controller.current_user }
end
