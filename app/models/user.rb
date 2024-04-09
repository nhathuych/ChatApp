class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :messages
  has_one_attached :avatar

  enum status: { offline: 0, online: 1, away: 2 }

  after_commit :add_default_avatar, on: [:create, :update]

  # broadcast a new user is created in users channel
  # won't have to refresh the page to see the new user appear
  after_create_commit { broadcast_append_to :users, target: 'js-users' }
  after_update_commit { broadcast_replace_to :user_status, partial: 'users/status', user: self }

  scope :all_except, -> (user) { where.not(id: user) }

  def avatar_thumbnail
    avatar.variant(resize_to_limit: [150, 150]).processed
  end

  def chat_avatar
    avatar.variant(resize_to_limit: [50, 50]).processed
  end

  def status_to_css
    case status_before_type_cast
    when 0
      'bg-dark'
    when 1
      'bg-success'
    else
      'bg-warning'
    end
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
