class HomeController < ApplicationController
  after_action :set_user_status

  def index
  end

  private

  def set_user_status
    # when user back to the home page, it's offline
    current_user.update!(status: User.statuses[:offline]) if current_user
  end
end
