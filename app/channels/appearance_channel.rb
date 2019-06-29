class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    p params
    stream_from "appearance_channel"

  end

  def unsubscribed
    #current_user.offline
    #stream_from "appearance_channel"
  end
end
