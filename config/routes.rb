Rails.application.routes.draw do
  root 'main#welcome'
  get 'email_links/new'
  post 'email_links/create', as: :magic_link
  get 'email_links/validate', as: :email_link
  devise_for :users
end
