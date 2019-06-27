module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      p "onlnin onlnin onlnin onlnin onlnin onlnin onlnin onlnin onlnin "
      self.current_user = find_verified_user
    end

    def disconnect
      p "offlin offlin offlin offlin offlin offlin offlin offlin offlin offlin "
    end
    private

    def find_verified_user
      if verified_user = User.find_by(id: cookies.signed['user.id'])
        p verified_user
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
