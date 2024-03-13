class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # broadcast a message after a new user is created 
  # I won't have to refresh the page to see the new user appear
  after_create_commit { broadcast_append_to "users" }

  scope :all_except, -> (user) { where.not(id: user) }
end
