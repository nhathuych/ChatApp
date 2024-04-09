class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from :appearance_channel
  end

  def unsubscribed
    stop_stream_from :appearance_channel
    offline
  end

  def online
    broadcast_new_status(User.statuses[:online])
  end

  def offline
    broadcast_new_status(User.statuses[:offline])
  end

  def away
    broadcast_new_status(User.statuses[:away])
  end

  def receive(data)
    ActionCable.server.broadcast(:appearance_channel, data)
  end

  private

  def broadcast_new_status(status)
    current_user.update!(status: status)
  end
end
