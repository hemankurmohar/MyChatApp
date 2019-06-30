class Message < ApplicationRecord
  belongs_to :friend
  mount_uploader :file_name, MediaUploader

  def partner_id
    friend = Friend.find(self.friend_id)
    return (friend.user_1_id==self.user_id)? friend.user_2_id : friend.user_1_id
  end
end
