class Friend < ApplicationRecord

  ## method to find whether searched username is friend of current logged in user or not.
  def self.find_friend_user_id(current_user,user_id)
    friends = Friend.where("user_1_id=? or user_2_id=?",current_user,current_user)
    @friends_user_id = []
    friends.pluck(:user_1_id,:user_2_id).each do |friend|
      (friend[0]==current_user)? @friends_user_id << friend[1] : @friends_user_id << friend[0]
    end
    if @friends_user_id.include?(user_id)
      return friends[@friends_user_id.index(user_id)].id
    end
    return nil
  end


  def partner_id(user_id)
   return (self.user_1_id==user_id)? self.user_2_id : self.user_1_id
  end
end
