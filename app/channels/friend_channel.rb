class FriendChannel < ApplicationCable::Channel
  def subscribed
    friend = Friend.find(params[:friend])
    stream_for friend

    # or
     #stream_from "friend_#{params[:friend]}"
  end

  def unsubscribed
    #current_user.offline
  end
end