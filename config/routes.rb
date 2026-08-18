Rails.application.routes.draw do
  devise_for :admins, skip: :registrations, controllers: {
    sessions: "admins/sessions",
    passwords: "admins/passwords"
  }

  mount_avo

  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"
end
