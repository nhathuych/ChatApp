class Room < ApplicationRecord
  has_many :messages

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # broadcast in rooms channel
  after_create_commit { broadcast_append_to :rooms, target: 'js-rooms' }

  scope :public_rooms, -> { where(is_private: false) }
end
