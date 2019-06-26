class ChatsController < ApplicationController
  before_action :show_friends
  def index

  end

  def chat_box
    @username = params[:username]
  end

  def show
    @message = Message.new
    @username = params[:username]
    user_id = User.find_by(username: @username)
    if user_id
      @friend_id = Friend.find_friend_user_id(current_user.id,user_id.id)
      if @friend_id
        @messages = Message.where(:friend_id => @friend_id)
        #FriendChannel.broadcast_to Friend.find(@friend_id), @message
      else
        flash[:alert] = "Currently you are not friend of #{@username}."
        redirect_to chat_index_path
      end
    else
      flash[:alert]="User doesn't exsists"
      redirect_to chat_index_path
    end

  end

  private
  def show_friends
    friends = Friend.where("user_1_id=? or user_2_id=?",current_user,current_user)
    @friends_user_id = []
    friends.pluck(:user_1_id,:user_2_id).each do |friend|
      (friend[0]==current_user.id)? @friends_user_id << friend[1] : @friends_user_id << friend[0]
    end
    @f_name_map = User.where(:id=>@friends_user_id).map{|x| [x.id,x.username]}.to_h
    @f_uname_map = User.where(:id=>@friends_user_id).map{|x| [x.id,x.username]}.to_h

  end
end
