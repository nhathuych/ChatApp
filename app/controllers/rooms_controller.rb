class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_current_room, only: :show

  def index
    @room  = Room.new
    @rooms = Room.public_rooms
    @users = User.all_except(current_user)
  end

  def show
    @room  = Room.new
    @rooms = Room.public_rooms

    @message  = Message.new
    @messages = @current_room.messages.includes(:user).order(id: :asc)

    @users = User.all_except(current_user)

    render :index
  end

  def create
    @room = Room.create(name: params.dig(:room, :name))
  end

  private

  def load_current_room
    @current_room = Room.find(params[:id])
  end
end
