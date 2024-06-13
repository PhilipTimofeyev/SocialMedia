class FollowChannel < ApplicationCable::Channel
  def subscribed
    stream_from "follow"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
