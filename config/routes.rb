Rails.application.routes.draw do
  resources :messages
  resources :friends
  devise_for :users
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/chats",to: 'chats#index',as: :chat_index
  get "/chats/:username",to: 'chats#show',as: :show_chat

end
