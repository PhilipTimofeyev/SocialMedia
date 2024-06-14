class FollowChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak
    trasmit("hello")
  end

  def receive(data)
    user_id = data["follow"]["user_id"]
    # data['user'] = current_user
    # message = "subscribe"
    # debugger
    user = User.find(user_id)
    # ActionCable.server.broadcast(user, current_user)
    FollowChannel.broadcast_to(user, { from_user: current_user })
  end

end
