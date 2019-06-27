class FriendChannel < ApplicationCable::Channel
  def subscribed
    p "subs subs subs subs subs subs subs subs subs subs subs subs subs "
    friend = Friend.find(params[:friend])
    stream_for friend
    # or
     #stream_from "friend_#{params[:friend]}"
  end

  def unsubscribed
    p "unsc unsc unsc unsc unsc unsc unsc unsc unsc unsc "
    #REDIS.srem("online", self.id)
    #current_user.offline
  end
end