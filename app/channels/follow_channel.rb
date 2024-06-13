class FollowChannel < ApplicationCable::Channel
  def subscribed
    stream_from "follow"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    data['user'] = current_user
    ActionCable.server.broadcast('follow', data)
  end


end
