class FriendChannel < ApplicationCable::Channel
  def subscribed
    p "dkdnakdnadnakdajkdnak"
    p params
    friend = Friend.find(params[:friend])
    stream_for friend
    # or
     #stream_from "friend_#{params[:friend]}"
  end
end