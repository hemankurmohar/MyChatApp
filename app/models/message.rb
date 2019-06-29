class Message < ApplicationRecord
  belongs_to :friend
  mount_uploader :file_name, MediaUploader
end
