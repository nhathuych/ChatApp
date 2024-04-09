class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :messages

  has_one_attached :avatar

  after_commit :add_default_avatar, on: [:create, :update]

  # broadcast a new user is created in users channel
  # won't have to refresh the page to see the new user appear
  after_create_commit { broadcast_append_to :users, target: 'js-users' }

  scope :all_except, -> (user) { where.not(id: user) }

  def avatar_thumbnail
    avatar.variant(resize_to_limit: [150, 150]).processed
  end

  def chat_avatar
    avatar.variant(resize_to_limit: [50, 50]).processed
  end

  private

  def add_default_avatar
    # return avatar.purge if avatar.attached?
    return if avatar.attached?

    avatar.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', 'avatars', 'default-profile.png')),
      filename: 'default-profile.png',
      content_type: 'image/png'
    )
  end
end
