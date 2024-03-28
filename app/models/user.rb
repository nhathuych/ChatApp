class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :messages

  # broadcast a new user is created in users channel
  # won't have to refresh the page to see the new user appear
  after_create_commit { broadcast_append_to :users, target: 'js-users' }

  scope :all_except, -> (user) { where.not(id: user) }
end
