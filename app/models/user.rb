class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: true, presence: true
  has_many :friends, foreign_key: :user_id_1

  def offline
    REDIS.zrem("online_users",self.id)
    ActionCable.server.broadcast "appearance_channel",{:id => self.id,:status=> false}
  end

  def online
    REDIS.zadd("online_users",1,self.id)
    # total_online_users = REDIS.zcard("online_users")
    # users = REDIS.zrange("online_users",0,total_online_users)
    # users = [1,5]
     ActionCable.server.broadcast "appearance_channel",{:id => self.id,:status=> true}
  end
end
