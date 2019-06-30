class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    p params
    stream_from "appearance_channel"
    #stream_from "notifications_channel_#{current_user.id}"
    stream_for current_user
  end

  def unsubscribed
    #current_user.offline
    #stream_from "appearance_channel"
  end
end
