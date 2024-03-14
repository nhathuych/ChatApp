class Rooms::MessagesController < ApplicationController
  def create
    @message = current_user.messages.create(message_params)
  end

  private

  def message_params
    params.require(:message).permit(:body).merge(room_id: params[:room_id])
  end
end
