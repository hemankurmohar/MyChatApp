Rails.application.routes.draw do
  resources :messages
  resources :friends
  devise_for :users
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/chats",to: 'chats#index',as: :chat_index
  get "/chats/:username",to: 'chats#show',as: :show_chat
  post "/messages/upload_attachment",to: 'messages#upload_attachment',as: :upload_attachment
  get "/friends/add/(:user_id)",to: 'friends#add',as: :add_friend
  get "/friends/approve/(:user_id)",to: 'friends#approve',as: :approve_friend
  get "/documents/users/profile_pic/:user_id",to: 'chats#profile_pic',as: :profile_pic
  get "/chats/attachment/:message_id",to: 'chats#show_attachment',as: :show_attachment
  root controller: :chats, action: :index
end
