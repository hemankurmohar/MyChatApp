class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: true, presence: true
  has_many :friends, foreign_key: :user_id_1

  mount_uploader :avtar, AvtarUploader

  def offline
    REDIS.zrem("online_users",self.id)
    ActionCable.server.broadcast "appearance_channel",{:id => self.id,:status=> false}
  end

  def online
    REDIS.zadd("online_users",1,self.id)
    ActionCable.server.broadcast "appearance_channel",{:id => self.id,:status=> true}
  end

  def avtar_url
    self.avtar
  end
end
