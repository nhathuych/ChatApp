class Room < ApplicationRecord
  has_many :messages
  has_many :participants, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # broadcast in rooms channel
  after_create_commit { broadcast_append_to :rooms, target: 'js-rooms' }

  scope :public_rooms, -> { where(is_private: false) }

  def participant?(room, user)
    room.participants.where(user_id: user.id).exists?
  end
end
